//
//  Product.swift
//  ShopApp
//
//  Created by Andres Felipe Rojas R. on 27/03/21.
//

import UIKit

struct Product: Codable, Collectible {

    let id: String
    let title: String
    let price: Double
    let availableQuantity: Int
    let condition: Condition
    let thumbnail: String
    let acceptsMercadopago: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case availableQuantity = "available_quantity"
        case condition
        case thumbnail
        case acceptsMercadopago = "accepts_mercadopago"
    }

    func getCollectionCell() -> UICollectionViewCell {

        return UICollectionViewCell()
    }
}
