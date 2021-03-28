//
//  Item.swift
//  ShopApp
//
//  Created by Andres Felipe Rojas R. on 27/03/21.
//

import Foundation

struct Item: Codable {
    let id: String
    let title: String
    let subtitle: String?
    let categoryId: String?
    let price: Double
    let availableQuantity: Int
    let condition: Condition
    let thumbnail: String?
    let secureThumbnail: String?
    let pictures: [Picture]?
    let acceptsMercadopago: Bool
    let sellerAddress: SellerAddress?
    let warranty: String?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case subtitle
        case categoryId = "category_id"
        case price
        case availableQuantity = "available_quantity"
        case condition
        case thumbnail
        case secureThumbnail = "secure_thumbnail"
        case pictures
        case acceptsMercadopago = "accepts_mercadopago"
        case sellerAddress = "seller_address"
        case warranty
    }
}

struct Description: Codable {
    let plainText: String

    enum CodingKeys: String, CodingKey {
        case plainText = "plain_text"
    }
}
