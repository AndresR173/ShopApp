//
//  SearchResponse.swift
//  ShopApp
//
//  Created by Andres Felipe Rojas R. on 27/03/21.
//

import Foundation

struct SearchResponse<T: Codable>: Codable {
    let paging: Paging
    let results: [T]
}

struct Paging: Codable {
    let total: Int
    let offset: Int
    let limit: Int
}
