//
//  CustomViewController.swift
//  ShopApp
//
//  Created by Andres Felipe Rojas R. on 28/03/21.
//

import UIKit

class CustomViewController<ViewType: UIView>: UIViewController {

    // MARK: - Properties

    var customView: ViewType {
        // swiftlint:disable:next force_cast
        return view as! ViewType
    }

    private(set) lazy var navigationBarBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    override func loadView() {
        view = ViewType(frame: UIScreen.main.bounds)
    }

    // MARK: - Life Cycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super .init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(navigationBarBackgroundView)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(recognizer:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    // MARK: - Actions

    @objc private func dismissKeyboard(recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }

}
