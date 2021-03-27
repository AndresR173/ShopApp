//
//  Price.swift
//  ShopApp
//
//  Created by Andres Felipe Rojas R. on 27/03/21.
//

import Foundation

struct Picture: Codable {
    let id: String
    let url: String
    let secureUrl: String

    enum CodingKeys: String, CodingKey {
        case id
        case url
        case secureUrl = "secure_url"
    }
}
