//
//  ProductDetailViewController.swift
//  ShopApp
//
//  Created by Andres Felipe Rojas R. on 28/03/21.
//

import Lottie
import UIKit

class ProductDetailViewController: CustomViewController<ProductDetailView> {

    // MARK: - Properties

    let viewModel: ProductDetailViewModelProtocol

    private var tableSection = TableViewSection()

    // MARK: - Life cycle

    init(viewModel: ProductDetailViewModelProtocol) {

        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
    }

}

// MARK: - Helper methods

private extension ProductDetailViewController {

    func setupUI() {

        /// Register all the custom classes for the tableview cells
        customView.tableView.register(GalleryTableViewCell.self,
                                      forCellReuseIdentifier: String(describing: GalleryTableViewCell.self))
        customView.tableView.register(TitleTableViewCell.self,
                                      forCellReuseIdentifier: String(describing: TitleTableViewCell.self))
        customView.tableView.register(ProductDetailsTableViewCell.self,
                                      forCellReuseIdentifier: String(describing: ProductDetailsTableViewCell.self))
        customView.tableView.dataSource = self
        customView.tableView.delegate = self
        customView.tableView.rowHeight = UITableView.automaticDimension
        customView.tableView.estimatedRowHeight = 100

        setupBindings()

        /// Load product details
        viewModel.getItem()
    }

    // swiftlint:disable:next function_body_length
    func setupBindings() {

        viewModel.animation.bind {[weak self] animation in

            if let animation = animation {

                self?.customView.animationView.animation = Animation.named(animation.animation)
                self?.customView.messageLabel.text = animation.message
                self?.customView.animationView.loopMode = .loop
                self?.customView.animationView.play()
                self?.customView.animationContainer.fadeIn()
            } else {

                self?.customView.animationView.stop()
                self?.customView.animationView.fadeOut()
            }
        }

        viewModel.gallery.bind {[weak self] gallery in

            guard let strongSelf = self, let gallery = gallery else {
                return
            }

            var row = TableRow(cellClass: GalleryTableViewCell.self)

            row.configureCell = { (cell, _) in

                guard let cell = cell as? GalleryTableViewCell else {
                    return
                }

                cell.gallery = gallery
            }

            row.height = {[weak self] _ in
                /// Set gallery height, the layout might change if the device is in landscape or portrait mode
                if UIDevice.current.orientation.isLandscape {

                    return (self?.view.frame.width ?? 0) * 0.3
                }
                return (self?.view.frame.width ?? 0) * 0.8
            }

            /// Gallery will be always the first element on the list
            strongSelf.tableSection.rows.insert(row, at: 0)
            strongSelf.customView.tableView.reloadData()
        }

        viewModel.title.bind { [weak self] title in

            guard let strongSelf = self, let title = title else {
                return
            }

            var row = TableRow(cellClass: TitleTableViewCell.self)

            row.configureCell = { (cell, _) in

                guard let cell = cell as? TitleTableViewCell else {
                    return
                }

                cell.title = title
            }

            strongSelf.tableSection.rows.append(row)
            strongSelf.customView.tableView.reloadData()
        }

        viewModel.details.bind { [weak self] details in

            guard let strongSelf = self, let details = details else {
                return
            }

            var row = TableRow(cellClass: ProductDetailsTableViewCell.self)

            row.configureCell = { (cell, _) in

                guard let cell = cell as? ProductDetailsTableViewCell else {
                    return
                }

                cell.details = details
            }

            strongSelf.tableSection.rows.append(row)
            strongSelf.customView.tableView.reloadData()
        }

        viewModel.price.bind { [weak self] price in

            self?.customView.priceLabel.text = price
        }
    }

    /// Get TableRow at indexPath
    func rowAtIndexPath(_ indexPath: IndexPath) -> TableRow {

        return tableSection.rows[indexPath.row]
    }
}

// MARK: - TableView Delegate - DataSource

extension ProductDetailViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return tableSection.rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let row = rowAtIndexPath(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: row.reuseIdentifier, for: indexPath)
        if let configureCell = row.configureCell {

            configureCell(cell, indexPath)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        let row = rowAtIndexPath(indexPath)
        if let height = row.height {

            return height(indexPath)
        }
        return tableView.rowHeight
    }

}
