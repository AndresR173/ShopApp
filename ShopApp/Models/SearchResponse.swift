//
//  SearchResponse.swift
//  ShopApp
//
//  Created by Andres Felipe Rojas R. on 27/03/21.
//

import Foundation

struct SearchResponse<T: Codable>: Codable {
    let siteId: String
    let query: String
    let paging: Paging
    let results: [T]

    enum CodingKeys: String, CodingKey {
        case siteId = "site_id"
        case query
        case paging
        case results
    }
}

struct Paging: Codable {
    let total: Int
    let offset: Int
    let limit: Int
}
