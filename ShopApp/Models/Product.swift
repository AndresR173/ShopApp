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
    let address: Address

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case availableQuantity = "available_quantity"
        case condition
        case thumbnail
        case acceptsMercadopago = "accepts_mercadopago"
        case address
    }

    func getCollectionCell(from collectionView: UICollectionView, for indexPath: IndexPath) -> UICollectionViewCell? {

        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: ProductCollectionViewCell.self),
                for: indexPath) as? ProductCollectionViewCell else {

            return nil
        }

        cell.product = self

        return cell
    }
}

struct Address: Codable {
    let stateId: String
    let stateName: String
    let cityName: String

    enum CodingKeys: String, CodingKey {
        case stateId = "state_id"
        case stateName = "state_name"
        case cityName = "city_name"
    }
}
