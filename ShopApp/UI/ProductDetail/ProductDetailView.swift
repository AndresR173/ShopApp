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

        setupConstraints()
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([

            animationContainer.leadingAnchor.constraint(equalTo: readableContentGuide.leadingAnchor, constant: 16),
            animationContainer.trailingAnchor.constraint(equalTo: readableContentGuide.trailingAnchor, constant: -16),
            animationContainer.centerYAnchor.constraint(equalTo: centerYAnchor),

            animationView.heightAnchor.constraint(equalTo: animationContainer.widthAnchor),

            tableView.topAnchor.constraint(equalTo: readableContentGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: readableContentGuide.bottomAnchor)
        ])
    }
}
