//
//  ProductDetailsTableViewCell.swift
//  ShopApp
//
//  Created by Andres Felipe Rojas R. on 28/03/21.
//

import UIKit

class ProductDetailsTableViewCell: UITableViewCell {

    // MARK: - Properties

    private lazy var titleLabel = UILabel()
        .with { label in

            label.font = .monserrat(.medium, size: 18)
            label.numberOfLines = 2
            label.text = "Product details".L
        }

    private lazy var descriptionLabel = UILabel()
        .with { label in

            label.font = .monserrat(.regular, size: 14)
            label.numberOfLines = 0
        }

    var details: String? {
        didSet {

            descriptionLabel.text = details
        }
    }

    // MARK: - Life Cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupUI()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Helpers

private extension ProductDetailsTableViewCell {

     func setupUI() {

        backgroundColor = .clear
        selectionStyle = .none

        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)

        setupConstraints()
    }

     func setupConstraints() {

        NSLayoutConstraint.activate([

            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
     }

}
