//
//  ApiClient.swift
//  ShopApp
//
//  Created by Andres Felipe Rojas R. on 27/03/21.
//

import Foundation
import Combine

struct APIClient {

    struct Response<T> {

        let value: T
        let response: URLResponse
    }

    func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<Response<T>, Error> {

        return URLSession.shared
            .dataTaskPublisher(for: request) // Runs Http request
            .tryMap { result -> Response<T> in
                // Try to parse the response object
                let value = try JSONDecoder().decode(T.self, from: result.data)

                return Response(value: value, response: result.response)
            }
            .receive(on: DispatchQueue.main) // Move to main thread
            .eraseToAnyPublisher()
    }
}

enum NetworkError: Error {

    case serverError
    case badContent
    case badRequest
}
