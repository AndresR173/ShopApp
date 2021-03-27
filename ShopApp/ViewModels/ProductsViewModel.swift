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

    var elements: Box<[Collectible]?> { get }

    var animation: Box<AppAnimation?> { get }
}

final class ProductsViewModel: ProductsViewModelProtocol {

    // MARK: - Properties

    var elements: Box<[Collectible]?> = Box(nil)
    var animation: Box<AppAnimation?> = Box(nil)

    private var cancellables = Set<AnyCancellable>()
    let service: ProductsService

    private let limit = 20
    private var offset = 0

    init(service: ProductsService) {

        self.service = service
    }

}

// MARK: - Helper Methods

extension ProductsViewModel {

    func search(for product: String) {

        animation.value = AppAnimation(animation: Constants.Animations.searching, message: "Searching".L)
        elements.value = nil
        let sOffset = String(offset)
        let sLimit = String(limit)
        service.searchProducts(for: product, offset: sOffset, limit: sLimit)
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

    func getCategories() {

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

}
