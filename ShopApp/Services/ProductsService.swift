//
//  ProductService.swift
//  ShopApp
//
//  Created by Andres Felipe Rojas R. on 27/03/21.
//

import Foundation
import Combine

protocol ProductsService {
    func searchProductsFor(key: String, offset: String, limit: String) -> AnyPublisher<SearchResponse<Product>, Error>
}

final class ProductServiceClient: ProductsService {

    // MARK: - Properties
    private let apiClient = APIClient()

    // MARK: - Methods

    func searchProductsFor(key: String, offset: String, limit: String) -> AnyPublisher<SearchResponse<Product>, Error> {

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
}
