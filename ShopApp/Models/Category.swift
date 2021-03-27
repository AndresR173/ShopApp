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

    func getCollectionCell(from collectionView: UICollectionView, for indexPath: IndexPath) -> UICollectionViewCell? {

        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: CategoryCollectionViewCell.self),
                for: indexPath) as? CategoryCollectionViewCell else {

            return nil
        }

        cell.category = self

        return cell
    }
}
