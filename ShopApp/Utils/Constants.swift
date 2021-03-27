//
//  Constants.swift
//  ShopApp
//
//  Created by Andres Felipe Rojas R. on 27/03/21.
//

import UIKit

struct Constants {
    struct Api {
        static let host = "api.mercadolibre.com"
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
            static let products = "/sites/\(Constants.Api.siteId)/search"
            static let categories = "/sites/\(Constants.Api.siteId)/categories"
        }
    }

    struct Colors {
        static let pastelColors = [
            UIColor(named: "BilobaFlower") ?? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
            UIColor(named: "CreamBrulee") ?? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
            UIColor(named: "Deco") ?? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
            UIColor(named: "LavenderPink") ?? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
            UIColor(named: "Malibu") ?? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
            UIColor(named: "Melon") ?? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        ]
    }

    struct Animations {
        static let error = "error"
        static let empty = "empty"
        static let searching = "searching"
    }
}
