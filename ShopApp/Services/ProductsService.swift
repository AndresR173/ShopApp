//
//  ProductService.swift
//  ShopApp
//
//  Created by Andres Felipe Rojas R. on 27/03/21.
//

import Foundation
import Combine

protocol ProductsService {
    func searchProducts(for key: String,
                        offset: String,
                        limit: String) -> AnyPublisher<SearchResponse<Product>, Error>
    func getCategories() -> AnyPublisher<[ProductCategory], Error>
    func searchProductsByCategory(_ category: String,
                                  offset: String,
                                  limit: String) -> AnyPublisher<SearchResponse<Product>, Error>
}

final class ProductServiceClient: ProductsService {

    // MARK: - Properties

    private let apiClient = APIClient()

    // MARK: - Methods

    /**
        Retrieves product catalog for a keyword
        - parameters:
            - key: Ke word, this can be more than one word
            - offset: Initial position (Use this parameter to the se beginning of the page)
            - limit: The total of elements per page
     */
    func searchProducts(for key: String,
                        offset: String,
                        limit: String) -> AnyPublisher<SearchResponse<Product>, Error> {

        var urlComponents = Constants.Api.getBaseURLComponents()
        urlComponents.path = Constants.Api.Paths.products
        let queryString = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: queryString),
            URLQueryItem(name: "offset", value: offset),
            URLQueryItem(name: "limit", value: limit)
        ]

        guard let url = urlComponents.url else {
            return Fail(error: NetworkError.badRequest).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return apiClient.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }

    func getCategories() -> AnyPublisher<[ProductCategory], Error> {

        var urlComponents = Constants.Api.getBaseURLComponents()
        urlComponents.path = Constants.Api.Paths.categories

        guard let url = urlComponents.url else {
            return Fail(error: NetworkError.badRequest).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return apiClient.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }

    /**
        Retrieves product catalog by category
        - parameters:
            - category: Category ID
            - offset: Initial position (Use this parameter to the se beginning of the page)
            - limit: The total of elements per page
     */
    func searchProductsByCategory(_ category: String,
                                  offset: String,
                                  limit: String) -> AnyPublisher<SearchResponse<Product>, Error> {

        var urlComponents = Constants.Api.getBaseURLComponents()
        urlComponents.path = Constants.Api.Paths.products
        urlComponents.queryItems = [
            URLQueryItem(name: "category", value: category),
            URLQueryItem(name: "offset", value: offset),
            URLQueryItem(name: "limit", value: limit)
        ]

        guard let url = urlComponents.url else {
            return Fail(error: NetworkError.badRequest).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return apiClient.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
