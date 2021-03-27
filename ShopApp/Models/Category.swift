//
//  Category.swift
//  ShopApp
//
//  Created by Andres Felipe Rojas R. on 27/03/21.
//

import UIKit

struct Category: Codable, Collectible {

    let id: String
    let name: String

    func getCollectionCell() -> UICollectionViewCell {

        return UICollectionViewCell()
    }
}
