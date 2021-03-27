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
    @IBOutlet weak var errorMessageLabel: UILabel!

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

    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    private let itemsPerRow: CGFloat = 2

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
        collectionView.register(UINib(nibName: String(describing: CategoryCollectionViewCell.self), bundle: .main),
                                forCellWithReuseIdentifier: String(describing: CategoryCollectionViewCell.self))

        animationView.frame = animationContainer.bounds
        animationContainer.addSubview(animationView)

        setupBindings()
    }

    func setupBindings() {

        viewModel.elements.bind { [weak self] elements in

            if elements == nil {

                self?.collectionView.fadeOut()
            } else {

                self?.collectionView.reloadData()
                self?.collectionView.fadeIn()
            }
        }

        viewModel.animation.bind {[weak self] animation in

            if let animation = animation {

                self?.animationView.animation = Animation.named(animation.animation)
                self?.animationView.loopMode = .loop
                self?.animationView.play()
                self?.animationContainer.fadeIn()

                self?.errorMessageLabel.text = animation.message
                self?.errorMessageLabel.fadeIn()
            } else {

                self?.animationView.stop()
                self?.animationContainer.fadeOut()
                self?.errorMessageLabel.fadeOut()
            }
        }

    }
}

// MARK: Protocol implementation (UISearchBarDelegate)

extension ProductsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }

        viewModel.search(for: text)
    }
}

// MARK: - Protocol implementation (UICollectionViewDelegate, UICollectionViewDataSource)

extension ProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.elements.value?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.getCollectionViewCell(from: collectionView, for: indexPath)
    }
}

// MARK: - Protocol implementation (UICollectionViewDelegateFlowLayout)

extension ProductsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath
      ) -> CGSize {

        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow

        return CGSize(width: widthPerItem, height: widthPerItem)
      }

      func collectionView(_ collectionView: UICollectionView,
                          layout collectionViewLayout: UICollectionViewLayout,
                          insetForSectionAt section: Int
      ) -> UIEdgeInsets {
        return sectionInsets
      }

      func collectionView(_ collectionView: UICollectionView,
                          layout collectionViewLayout: UICollectionViewLayout,
                          minimumLineSpacingForSectionAt section: Int
      ) -> CGFloat {
        return sectionInsets.left
      }
}
