//
//  ItemsService.swift
//  ShopApp
//
//  Created by Andres Felipe Rojas R. on 27/03/21.
//

import Combine
import Foundation

protocol ItemsService {
    func searchItem(_ id: String) -> AnyPublisher<Item, Error>
    func getItemDescription(_ id: String) -> AnyPublisher<Description, Error>
}

struct ItemsServiceClient: ItemsService {

    // MARK: - Properties

    private let apiClient = APIClient()

    // MARK: - Methods

    /**
        Search specific item
        - parameters:
            - id: Item id
     */
    func searchItem(_ id: String) -> AnyPublisher<Item, Error> {

        var urlComponents = Constants.Api.getBaseURLComponents()
        urlComponents.path = "\(Constants.Api.Paths.items)/\(id)"

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
        Retrieves the description for a specific item
        - parameters:
            - id: Item id
     */
    func getItemDescription(_ id: String) -> AnyPublisher<Description, Error> {

        var urlComponents = Constants.Api.getBaseURLComponents()
        urlComponents.path = "\(Constants.Api.Paths.items)/\(id)/description"

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
