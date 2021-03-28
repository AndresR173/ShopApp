//
//  MockApi.swift
//  ShopAppTests
//
//  Created by Andres Felipe Rojas R. on 28/03/21.
//

import Combine
import Foundation
@testable import ShopApp

class MockApi: ProductsService {

    func searchProducts(for key: String,
                        offset: String,
                        limit: String) -> AnyPublisher<SearchResponse<Product>, Error> {

        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "search_response", withExtension: "json") else {
            return Fail(error: NetworkError.badContent).eraseToAnyPublisher()
        }

        guard let data = try? Data(contentsOf: url) else {
            return Fail(error: NetworkError.badContent).eraseToAnyPublisher()
        }

        guard let response = try? JSONDecoder().decode(SearchResponse<Product>.self, from: data) else {
            return Fail(error: NetworkError.badContent).eraseToAnyPublisher()
        }

        return Just(response).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    func getCategories() -> AnyPublisher<[ProductCategory], Error> {

        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "categories_response", withExtension: "json") else {
            return Fail(error: NetworkError.badContent).eraseToAnyPublisher()
        }

        guard let data = try? Data(contentsOf: url) else {
            return Fail(error: NetworkError.badContent).eraseToAnyPublisher()
        }

        guard let response = try? JSONDecoder().decode([ProductCategory].self, from: data) else {
            return Fail(error: NetworkError.badContent).eraseToAnyPublisher()
        }

        return Just(response).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    func searchProductsByCategory(_ category: String,
                                  offset: String,
                                  limit: String) -> AnyPublisher<SearchResponse<Product>, Error> {

        let bundle = Bundle(for: type(of: self))
        guard let url = bundle.url(forResource: "search_response", withExtension: "json") else {
            return Fail(error: NetworkError.badContent).eraseToAnyPublisher()
        }

        guard let data = try? Data(contentsOf: url) else {
            return Fail(error: NetworkError.badContent).eraseToAnyPublisher()
        }

        guard let response = try? JSONDecoder().decode(SearchResponse<Product>.self, from: data) else {
            return Fail(error: NetworkError.badContent).eraseToAnyPublisher()
        }

        return Just(response).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

}

class MockErrorApi: ProductsService {

    func searchProducts(for key: String,
                        offset: String,
                        limit: String) -> AnyPublisher<SearchResponse<Product>, Error> {
        return Fail(error: NetworkError.badContent).eraseToAnyPublisher()
    }

    func getCategories() -> AnyPublisher<[ProductCategory], Error> {
        return Fail(error: NetworkError.badContent).eraseToAnyPublisher()
    }

    func searchProductsByCategory(_ category: String,
                                  offset: String,
                                  limit: String) -> AnyPublisher<SearchResponse<Product>, Error> {
        return Fail(error: NetworkError.badContent).eraseToAnyPublisher()
    }

}
