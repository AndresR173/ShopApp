//
//  CategoryCollectionViewCell.swift
//  ShopApp
//
//  Created by Andres Felipe Rojas R. on 27/03/21.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets

    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var containerView: UIView!

    // MARK: - Properties

    var category: ProductCategory? {
        didSet {
            setupUI()
        }
    }

    // MARK: - Helper Methods

    private func setupUI() {

        guard let category = category else {
            return
        }

        let color = Constants.Colors.pastelColors.randomElement() ?? UIColor.white

        containerView.layer.cornerRadius = 7
        containerView.backgroundColor = color
        categoryTitleLabel.text = category.name
        categoryTitleLabel.textColor = color.isDarkColor ? .white : .black
    }

}
