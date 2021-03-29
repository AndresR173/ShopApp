//
//  SellerAddress.swift
//  ShopApp
//
//  Created by Andres Felipe Rojas R. on 27/03/21.
//

import Foundation

struct SellerAddress: Codable {
    let city: IdValue
    let state: IdValue
    let country: IdValue
}

struct IdValue: Codable {
    let id: String
    let name: String
}
