//
//  Constants.swift
//  ShopApp
//
//  Created by Andres Felipe Rojas R. on 27/03/21.
//

import Foundation

struct Constants {
    struct Api {
        static let host = "https://api.mercadolibre.com"
        static let scheme = "https"
        static let siteId = "MCO"

        static func getBaseURLComponents() -> URLComponents {
            var components = URLComponents()
            components.scheme = Constants.Api.scheme
            components.host = Constants.Api.host

            return components
        }

        // swiftlint:disable:next nesting
        struct Paths {
            static let items = "/items"
            static let products = "sites/\(Constants.Api.siteId)/search"
        }
    }
}
