//
//  TableRow.swift
//  ShopApp
//
//  Created by Andres Felipe Rojas R. on 28/03/21.
//

import UIKit

struct TableRow {

    init<T>(cellClass: T.Type) where T: UITableViewCell {
        reuseIdentifier = cellClass.reuseIdentifier
    }

    var identifier: String?

    var height: ((IndexPath) -> CGFloat)?

    var reuseIdentifier: String

    var configureCell: ((UITableViewCell, IndexPath) -> Void)?

    var didSelect: ((IndexPath) -> Void)?
}

extension UITableViewCell {

    static var reuseIdentifier: String {
        return String(describing: self)
    }

}
