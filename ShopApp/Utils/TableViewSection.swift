//
//  TableViewSection.swift
//  ShopApp
//
//  Created by Andres Felipe Rojas R. on 28/03/21.
//

import UIKit

struct TableViewSection {

    var identifier: String?

    var headerTitle: String?

    var headerHeight: ((Int) -> CGFloat)?

    var rows: [TableRow] = []

    var headerView: ((Int) -> UIView?)?

    var configureHeaderView: ((UIView, Int) -> Void)?
}
