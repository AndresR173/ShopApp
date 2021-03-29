//
//  Builder.swift
//  ShopApp
//
//  Created by Andres Felipe Rojas R. on 27/03/21.
//

import UIKit

protocol Builder {

    typealias Handler = (inout Self) -> Void
}

extension NSObject: Builder {}

extension Builder {

    public func with(_ configure: Handler) -> Self {

        var this = self
        configure(&this)

        if let view = self as? UIView {
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        return this
    }
}
