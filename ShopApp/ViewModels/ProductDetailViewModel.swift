//
//  ProductDetailViewModel.swift
//  ShopApp
//
//  Created by Andres Felipe Rojas R. on 28/03/21.
//

import Combine
import Foundation

protocol ProductDetailViewModelProtocol {

    func getItem()

    var animation: Box<AppAnimation?> { get }
    var gallery: Box<[Picture]?> { get }
    var title: Box<String?> { get }
    var details: Box<String?> { get }
    var price: Box<String?> { get }
}

final class ProductDetailViewModel: ProductDetailViewModelProtocol {

    // MARK: - Properties

    var animation: Box<AppAnimation?> = Box(AppAnimation(animation: Constants.Animations.searching,
                                                         message: nil))
    var gallery: Box<[Picture]?> = Box(nil)
    var title: Box<String?> = Box(nil)
    var details: Box<String?> = Box(nil)
    var price: Box<String?> = Box(nil)

    private var cancellables = Set<AnyCancellable>()
    private let productId: String
    private let service: ItemsService
    private var item: Item?

    // MARK: - Initializer

    init(productId: String, service: ItemsService) {

        self.productId = productId
        self.service = service

    }

}

// MARK: - Helper Methods

extension ProductDetailViewModel {

     func getItem() {

        animation.value = AppAnimation(animation: Constants.Animations.searching, message: nil)

        service.searchItem(productId)
            .mapError {[weak self] error -> Error in

                guard let strongSelf = self else {
                    return error
                }

                strongSelf.animation.value = AppAnimation(animation: Constants.Animations.error,
                                                          message: "Ops! something went wrong".L)

                return error
            }
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] item in

                    guard let strongSelf = self else {
                        return
                    }

                    strongSelf.item = item
                    strongSelf.animation.value = nil
                    strongSelf.showProductDetails()
                  }
            ).store(in: &cancellables)
    }

    private func showProductDetails() {

        guard let item = item else {
            return
        }

        animation.value = nil
        gallery.value = item.pictures
        title.value = item.title
        price.value = item.price.asCurrency

        service.getItemDescription(productId)
            .compactMap { $0 }
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] description in

                    guard let strongSelf = self else {
                        return
                    }

                    strongSelf.details.value = description.plainText
                  }
            ).store(in: &cancellables)
    }
}
