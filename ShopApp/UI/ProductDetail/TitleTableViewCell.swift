//
//  TitleTableViewCell.swift
//  ShopApp
//
//  Created by Andres Felipe Rojas R. on 28/03/21.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    // MARK: - Properties

    private lazy var titleLabel = UILabel()
        .with { label in

            label.font = .monserrat(.medium, size: 18)
            label.numberOfLines = 2
        }

    var title: String? {
        didSet {

            titleLabel.text = title
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

private extension TitleTableViewCell {

     func setupUI() {

        backgroundColor = .clear
        selectionStyle = .none

        contentView.addSubview(titleLabel)

        setupConstraints()
    }

     func setupConstraints() {

        NSLayoutConstraint.activate([

            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
     }

}
