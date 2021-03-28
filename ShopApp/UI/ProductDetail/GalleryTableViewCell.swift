//
//  GalleryTableViewCell.swift
//  ShopApp
//
//  Created by Andres Felipe Rojas R. on 28/03/21.
//

import SDWebImage
import UIKit

class GalleryTableViewCell: UITableViewCell {

    // MARK: - Properties

    private lazy var collectionView: UICollectionView = {

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 0.8)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = true

        return collectionView
    }()

    var gallery: [Picture]? {
        didSet {

            showGallery()
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

private extension GalleryTableViewCell {

     func setupUI() {

        backgroundColor = .clear
        selectionStyle = .none

        collectionView.register(GalleryImageCollectionViewCell.self,
                                forCellWithReuseIdentifier: String(describing: GalleryImageCollectionViewCell.self))
        contentView.addSubview(collectionView)

        setupConstraints()
    }

     func setupConstraints() {

        NSLayoutConstraint.activate([

            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8)
        ])
     }

    func showGallery() {

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
    }
}

// MARK: - Protocol implementation (UICollectionViewDataSource)

extension GalleryTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gallery?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: GalleryImageCollectionViewCell.self),
                for: indexPath) as? GalleryImageCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.picture = gallery?[indexPath.row]

        return cell
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        guard let count = gallery?.count else {
            return
        }

        let pageFloat = (scrollView.contentOffset.x / scrollView.frame.size.width)
        let pageInt = Int(round(pageFloat))

        switch pageInt {
        case 0:
            collectionView.scrollToItem(at: [0, count], at: .left, animated: false)
        case count - 1:
            collectionView.scrollToItem(at: [0, 1], at: .left, animated: false)
        default:
            break
        }
    }
}

class GalleryImageCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties

    private lazy var imageView = UIImageView()
        .with { image in

            image.contentMode = .scaleAspectFill
        }

    var picture: Picture? {
        didSet {

            guard let picture = picture else {
                return
            }

            imageView.sd_setImage(with: URL(string: picture.secureUrl),
                                  placeholderImage: UIImage(named: "placeholder"),
                                  options: .progressiveLoad,
                                  context: nil)
        }
    }

    // MARK: - Life cycle

    override init(frame: CGRect) {

        super.init(frame: frame)

        contentView.addSubview(imageView)

        NSLayoutConstraint.activate([

            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
