//
//  ProductCollectionViewCell.swift
//  ShopApp
//
//  Created by Andres Felipe Rojas R. on 27/03/21.
//

import UIKit
import SDWebImage

class ProductCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!

    // MARK: - Properties

    var product: Product? {
        didSet {

            setupUI()
        }
    }

    private func setupUI() {

        guard let product = product else {
            return
        }

        containerView.layer.cornerRadius = 7

        imageView.layer.cornerRadius = 7
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.sd_setImage(with: URL(string: product.thumbnail), placeholderImage: UIImage(named: "placeholder"))

        titleLabel.text = product.title

        priceLabel.text = product.price.asCurrency

        cityLabel.text = product.address.cityName
    }

}
