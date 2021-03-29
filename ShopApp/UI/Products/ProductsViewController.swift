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

        viewModel.getCategories()
    }

    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.largeTitleDisplayMode = .always
    }

    override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(animated)
        navigationItem.hidesSearchBarWhenScrolling = true
    }

    override func willTransition(to newCollection: UITraitCollection,
                                 with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.reloadData()
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
        navigationController?.navigationBar.prefersLargeTitles = true
        definesPresentationContext = true

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInsetAdjustmentBehavior = .always
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInsetReference = .fromSafeArea
        collectionView.collectionViewLayout = flowLayout

        let categoryCellIdentifier = String(describing: CategoryCollectionViewCell.self)
        collectionView.register(UINib(nibName: categoryCellIdentifier, bundle: .main),
                                forCellWithReuseIdentifier: categoryCellIdentifier)

        let productCellIdentifier = String(describing: ProductCollectionViewCell.self)
        collectionView.register(UINib(nibName: productCellIdentifier, bundle: .main),
                                forCellWithReuseIdentifier: productCellIdentifier)

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

                guard !(self?.viewModel.newElementsLoaded ?? false) else {
                    return
                }

                self?.collectionView.fadeIn()
                self?.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0),
                                                  at: .top,
                                                  animated: true)
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

        viewModel.currentCategory.bind {[weak self] category in

            guard let strongSelf = self else {
                return
            }

            if category != nil {

                let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                   target: self,
                                                   action: #selector(strongSelf.cancelCategorySearch))
                strongSelf.navigationItem.rightBarButtonItem = cancelButton
            } else {

                strongSelf.navigationItem.rightBarButtonItem = nil
            }
        }

        viewModel.productDetail.bind {[weak self] viewController in

            guard let viewController = viewController else {
                return
            }

            self?.navigationController?.pushViewController(viewController, animated: true)
        }

    }

    @objc func cancelCategorySearch() {

        viewModel.cancelCategorySearch()
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

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {

        viewModel.getCategories()
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath)
    }

    // Prefect data from api
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {

        guard let elements = viewModel.elements.value as? [Product] else {
            return
        }

        if indexPath.row == elements.count - 3 && !viewModel.isLoadingMoreElements {

            viewModel.loadMore()
        }
    }
}

// MARK: - Protocol implementation (UICollectionViewDelegateFlowLayout)

extension ProductsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        if !viewModel.isShowingCategories {
            let paddingSpace = viewModel.sectionInsets.left * 3
            let availableWidth = collectionView.frame.width - paddingSpace

            var columns: CGFloat = 1
            if UIDevice.current.orientation.isLandscape {
                columns = 2
            }

            return CGSize(width: availableWidth / columns, height: 100)
        }

        return CGSize(width: 150, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {

        return viewModel.sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return viewModel.sectionInsets.left
    }
}
