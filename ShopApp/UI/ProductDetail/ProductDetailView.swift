//
//  ProductDetailView.swift
//  ShopApp
//
//  Created by Andres Felipe Rojas R. on 28/03/21.
//

import Lottie
import UIKit

class ProductDetailView: UIView {

    // MARK: - Properties

     lazy var animationView = AnimationView().with { _ in }

     lazy var messageLabel = UILabel()
        .with { label in

            label.font = .monserrat(.medium, size: 15)
            label.textColor = .label
            label.textAlignment = .center
        }

     lazy var animationContainer = UIStackView()
        .with { stackView in

            stackView.axis = .vertical
            stackView.spacing = 8
            stackView.alpha = 0
            stackView.distribution = .fill
            stackView.addArrangedSubview(animationView)
            stackView.addArrangedSubview(messageLabel)
        }

    lazy var tableView = UITableView()
        .with { tableView in

            tableView.tableFooterView = UIView()
            tableView.separatorStyle = .none
            tableView.rowHeight = UITableView.automaticDimension
            tableView.insetsContentViewsToSafeArea = false
    }

    lazy var priceLabel = UILabel()
        .with { label in

            label.font = .monserrat(.semiBold, size: 18)
        }

    lazy var addToCartButton = UIButton(type: .custom)
        .with { button in

            button.setTitle("Add to Cart".L, for: .normal)
            button.titleLabel?.font = .monserrat(.medium, size: 15)
            button.backgroundColor = .systemGray3
            button.contentEdgeInsets = UIEdgeInsets(top: 0.0, left: 8.0, bottom: 0.0, right: 8.0)

            button.layer.cornerRadius = 20
        }

    private lazy var priceContainer = UIView()
        .with { view in
            view.layer.cornerRadius = 7
            view.backgroundColor = .systemGray6

            view.addSubview(priceLabel)
            view.addSubview(addToCartButton)
        }

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .systemBackground
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helper Methods

private extension ProductDetailView {

    func setupUI() {

        addSubview(animationContainer)
        addSubview(tableView)
        addSubview(priceContainer)

        setupConstraints()
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([

            animationContainer.leadingAnchor.constraint(equalTo: readableContentGuide.leadingAnchor, constant: 16),
            animationContainer.trailingAnchor.constraint(equalTo: readableContentGuide.trailingAnchor, constant: -16),
            animationContainer.centerYAnchor.constraint(equalTo: centerYAnchor),

            animationView.heightAnchor.constraint(equalTo: animationContainer.widthAnchor),

            priceContainer.leadingAnchor.constraint(equalTo: readableContentGuide.leadingAnchor),
            priceContainer.trailingAnchor.constraint(equalTo: readableContentGuide.trailingAnchor),
            priceContainer.bottomAnchor.constraint(equalTo: readableContentGuide.bottomAnchor, constant: -8),
            priceContainer.heightAnchor.constraint(equalToConstant: 50),

            priceLabel.leadingAnchor.constraint(equalTo: priceContainer.leadingAnchor, constant: 8),
            priceLabel.trailingAnchor.constraint(equalTo: priceContainer.trailingAnchor, constant: -8),
            priceLabel.centerYAnchor.constraint(equalTo: priceContainer.centerYAnchor),

            addToCartButton.trailingAnchor.constraint(equalTo: priceContainer.trailingAnchor, constant: -8),
            addToCartButton.heightAnchor.constraint(equalToConstant: 40),
            addToCartButton.centerYAnchor.constraint(equalTo: priceContainer.centerYAnchor),

            tableView.topAnchor.constraint(equalTo: readableContentGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: priceContainer.topAnchor, constant: -8)
        ])
    }
}
