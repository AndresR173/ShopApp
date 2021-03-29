//
//  MockItemService.swift
//  ShopAppTests
//
//  Created by Andres Felipe Rojas R. on 29/03/21.
//

import Combine
import Foundation
@testable import ShopApp

class MockItemService: ItemsService {
    func searchItem(_ id: String) -> AnyPublisher<Item, Error> {

        sleep(2)

        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "item_response", withExtension: "json") else {
            return Fail(error: NetworkError.badContent).eraseToAnyPublisher()
        }

        guard let data = try? Data(contentsOf: url) else {
            return Fail(error: NetworkError.badContent).eraseToAnyPublisher()
        }

        guard let item = try? JSONDecoder().decode(Item.self, from: data) else {
            return Fail(error: NetworkError.badContent).eraseToAnyPublisher()
        }

        return Just(item).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    func getItemDescription(_ id: String) -> AnyPublisher<Description, Error> {
        return Just(Description(plainText: "")).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

}
