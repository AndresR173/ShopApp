//
//  SearchProductsViewModel.swift
//  ShopApp
//
//  Created by Andres Felipe Rojas R. on 27/03/21.
//

import Combine
import UIKit

protocol Collectible {

    func getCollectionCell() -> UICollectionViewCell
}

protocol ProductsViewModelProtocol {

    func search(for product: String)
    func getCategories()

    var elements: Box<[Collectible]?> { get }

    var error: Box<Error?> { get }
}

final class ProductsViewModel: ProductsViewModelProtocol {

    // MARK: - Properties

    var elements: Box<[Collectible]?> = Box(nil)
    var error: Box<Error?> = Box(nil)

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

        let sOffset = String(offset)
        let sLimit = String(limit)
        service.searchProducts(for: product, offset: sOffset, limit: sLimit)
            .mapError { [weak self] error -> Error in

                guard let strongSelf = self else {
                    return error
                }

                strongSelf.error.value = error
                return error
            }
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] response in

                    guard let strongSelf = self else {
                        return
                    }

                    strongSelf.elements.value = response.results
                  }
            ).store(in: &cancellables)
    }

    func getCategories() {

        service.getCategories()
            .mapError { [weak self] error -> Error in

                guard let strongSelf = self else {
                    return error
                }

                strongSelf.error.value = error
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

}
