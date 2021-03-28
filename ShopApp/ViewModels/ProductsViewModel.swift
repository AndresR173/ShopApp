//
//  SearchProductsViewModel.swift
//  ShopApp
//
//  Created by Andres Felipe Rojas R. on 27/03/21.
//

import Combine
import UIKit

protocol Collectible {

    func getCollectionCell(from collectionView: UICollectionView, for indexPath: IndexPath) -> UICollectionViewCell?
}

protocol ProductsViewModelProtocol {

    func search(for product: String)
    func getCategories()
    func getCollectionViewCell(from collectionView: UICollectionView, for indexPath: IndexPath) -> UICollectionViewCell
    func didSelectItem(at indexPath: IndexPath)
    func cancelCategorySearch()
    func loadMore()

    var elements: Box<[Collectible]?> { get }
    var animation: Box<AppAnimation?> { get }
    var currentCategory: Box<Category?> { get }
    var newElementsLoaded: Bool { get }
    var elementsPerRow: CGFloat { get }
    var sectionInsets: UIEdgeInsets { get }
    var isLoadingMoreElements: Bool { get }
}

final class ProductsViewModel: ProductsViewModelProtocol {

    // MARK: - Properties

    var elements: Box<[Collectible]?> = Box(nil)
    var animation: Box<AppAnimation?> = Box(nil)
    var currentCategory: Box<Category?> = Box(nil)
    var newElementsLoaded = false
    var elementsPerRow: CGFloat = 2
    var sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    var isLoadingMoreElements: Bool = false

    private var cancellables = Set<AnyCancellable>()
    private let service: ProductsService
    private var currentKey: String?

    private let limit = 20
    private var offset = 0

    init(service: ProductsService) {

        self.service = service
    }

}

// MARK: - Helper Methods

extension ProductsViewModel {

    func search(for key: String) {

        currentKey = key
        animation.value = AppAnimation(animation: Constants.Animations.searching, message: "Searching".L)
        elements.value = nil
        elementsPerRow = 1
        sectionInsets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 0, right: 20.0)

        let sOffset = String(offset)
        let sLimit = String(limit)

        service.searchProducts(for: key, offset: sOffset, limit: sLimit)
            .mapError { [weak self] error -> Error in

                guard let strongSelf = self else {
                    return error
                }

                strongSelf.animation.value = AppAnimation(animation: Constants.Animations.error,
                                                          message: "Ops! something went wrong".L)
                return error
            }
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] response in

                    guard let strongSelf = self else {
                        return
                    }

                    strongSelf.animation.value = nil
                    if response.results.isEmpty {

                        strongSelf.animation.value = AppAnimation(animation: Constants.Animations.empty,
                                                                  // swiftlint:disable:next line_length
                                                                  message: "We could not find any results. Please try again".L)
                    } else {

                        strongSelf.elements.value = response.results
                    }

                  }
            ).store(in: &cancellables)
    }

    func getCategories() {

        elementsPerRow = 2
        currentKey = nil
        sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
        currentCategory.value = nil
        offset = 0
        animation.value = nil

        service.getCategories()
            .mapError { [weak self] error -> Error in

                guard let strongSelf = self else {
                    return error
                }

                strongSelf.animation.value = AppAnimation(animation: Constants.Animations.error,
                                                          message: "Oops! something went wrong".L)
                return error
            }
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] response in

                    guard let strongSelf = self else {
                        return
                    }

                    strongSelf.elements.value = response
                  }
            ).store(in: &cancellables)

    }

    func getCollectionViewCell(from collectionView: UICollectionView,
                               for indexPath: IndexPath) -> UICollectionViewCell {

        return elements.value?[indexPath.row].getCollectionCell(from: collectionView,
                                                                for: indexPath) ?? UICollectionViewCell()
    }

    func didSelectItem(at indexPath: IndexPath) {
        if let category = elements.value?[indexPath.row] as? Category {

            offset = 0
            currentCategory.value = category
            getProductsByCategory()
        } else if let product = elements.value?[indexPath.row] as? Product {

        }
    }

    private func getProductsByCategory() {

        guard let category = currentCategory.value else {
            return
        }

        elements.value = nil
        elementsPerRow = 1
        sectionInsets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 0, right: 20.0)
        animation.value = AppAnimation(animation: Constants.Animations.searching, message: "Searching".L)
        let sOffset = String(offset)
        let sLimit = String(limit)

        service.searchProductsByCategory(category.id, offset: sOffset, limit: sLimit)
            .mapError { [weak self] error -> Error in

                guard let strongSelf = self else {
                    return error
                }

                strongSelf.animation.value = AppAnimation(animation: Constants.Animations.error,
                                                          message: "Ops! something went wrong".L)
                return error
            }
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] response in

                    guard let strongSelf = self else {
                        return
                    }

                    strongSelf.animation.value = nil
                    strongSelf.elements.value = response.results
                  }
            ).store(in: &cancellables)
    }

    func loadMore() {

        if currentKey != nil {

            loadMoreProducts()
        } else if currentCategory.value != nil {

            loadMoreProductsByCategory()
        }
    }

    private func loadMoreProducts() {

        guard let key = currentKey else {
            return
        }

        offset += limit
        let sOffset = String(offset)
        let sLimit = String(limit)
        newElementsLoaded = false

        service.searchProducts(for: key, offset: sOffset, limit: sLimit)
            .mapError { error -> Error in

                return error
            }
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] response in

                    guard let strongSelf = self else {
                        return
                    }

                    if !response.results.isEmpty {

                        strongSelf.newElementsLoaded = true
                        strongSelf.elements.value?.append(contentsOf: response.results)
                    }

                  }
            ).store(in: &cancellables)
    }

    private func loadMoreProductsByCategory() {

        guard let category = currentCategory.value else {
            return
        }

        offset += limit
        let sOffset = String(offset)
        let sLimit = String(limit)
        newElementsLoaded = false

        service.searchProductsByCategory(category.id, offset: sOffset, limit: sLimit)
            .mapError { error -> Error in

                return error
            }
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] response in

                    guard let strongSelf = self else {
                        return
                    }

                    if !response.results.isEmpty {

                        strongSelf.newElementsLoaded = true
                        strongSelf.elements.value?.append(contentsOf: response.results)
                    }

                  }
            ).store(in: &cancellables)
    }

    @objc func cancelCategorySearch() {

        newElementsLoaded = false
        currentCategory.value = nil
        getCategories()
    }

}
