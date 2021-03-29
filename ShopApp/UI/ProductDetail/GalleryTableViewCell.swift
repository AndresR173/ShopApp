//
//  GalleryTableViewCell.swift
//  ShopApp
//
//  Created by Andres Felipe Rojas R. on 28/03/21.
//

import SDWebImage
import ImageSlideshow
import ImageSlideshowSDWebImage
import UIKit

class GalleryTableViewCell: UITableViewCell {

    // MARK: - Properties

    private lazy var slideShow = ImageSlideshow().with {_ in }

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

        contentView.addSubview(slideShow)

        setupConstraints()
    }

     func setupConstraints() {

        NSLayoutConstraint.activate([

            slideShow.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            slideShow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            slideShow.topAnchor.constraint(equalTo: contentView.topAnchor),
            slideShow.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
     }

    func showGallery() {

        guard let gallery = gallery else {
            return
        }

        let pageIndicator = UIPageControl()
        pageIndicator.currentPageIndicatorTintColor = .systemGray
        pageIndicator.pageIndicatorTintColor = .systemGray2
        slideShow.pageIndicator = pageIndicator

        let images = gallery.compactMap { URL(string: $0.secureUrl) }.map { SDWebImageSource(url: $0) }
        slideShow.setImageInputs(images)

    }
}
