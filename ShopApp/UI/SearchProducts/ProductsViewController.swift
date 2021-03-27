//
//  SearchProductViewController.swift
//  ShopApp
//
//  Created by Andres Felipe Rojas R. on 27/03/21.
//

import UIKit

class ProductsViewController: UIViewController {

    // MARK: - Outlets

    // MARK: - Properties

    private lazy var searchController: UISearchController = {

        let searchController = UISearchController(searchResultsController: nil)

        searchController.searchBar.placeholder = "What are you looking for?".L
        searchController.searchBar.searchBarStyle = .prominent
        searchController.searchBar.autocapitalizationType = .none
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self

       return searchController
    }()

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.hidesSearchBarWhenScrolling = true
    }

}

// MARK: - Helper methods

private extension ProductsViewController {

    func setupUI() {

        title = "Let's get started".L

        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont.monserrat(.semiBold, size: 32)
        ]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

// MARK: Protocol implementation (UISearchControllerDelegate)

extension ProductsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text = searchBar.text
        dump(text)
    }
}
