//
//  SearchProductViewController.swift
//  ShopApp
//
//  Created by Andres Felipe Rojas R. on 27/03/21.
//

import UIKit
import Lottie

class ProductsViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var animationContainer: UIView!

    // MARK: - Properties

    private lazy var searchController: UISearchController = UISearchController(searchResultsController: nil)
        .with { searchController in

            searchController.searchBar.placeholder = "What are you looking for?".L
            searchController.searchBar.searchBarStyle = .prominent
            searchController.searchBar.autocapitalizationType = .none
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.delegate = self
        }

    private lazy var animationView = AnimationView()

    let viewModel: ProductsViewModelProtocol

    // MARK: - Life cycle

    init(viewModel: ProductsViewModelProtocol) {
        self.viewModel = viewModel

        super.init(nibName: String(describing: ProductsViewController.self), bundle: Bundle.main)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        viewModel.getCategories()
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

        collectionView.delegate = self
        collectionView.dataSource = self

        animationView.frame = animationContainer.bounds
        animationContainer.addSubview(animationView)
    }
}

// MARK: Protocol implementation (UISearchBarDelegate)

extension ProductsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text = searchBar.text
        dump(text)
    }
}

// MARK: - Protocol implementation (UICollectionViewDelegate, UICollectionViewDataSource)

extension ProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
