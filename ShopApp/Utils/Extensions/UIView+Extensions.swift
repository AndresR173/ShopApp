//
//  UIView+Extensions.swift
//  ShopApp
//
//  Created by Andres Felipe Rojas R. on 27/03/21.
//

import UIKit

extension UIView {

    func fadeIn(_ duration: TimeInterval = 0.4,
                delay: TimeInterval = 0.0,
                completion: ((Bool) -> Void)? = nil) {

        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {

            self.alpha = 1.0
        }, completion: completion)
    }

    func fadeOut(_ duration: TimeInterval = 0.4,
                 delay: TimeInterval = 0.0,
                 completion: ((Bool) -> Void)? = nil) {

        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {

            self.alpha = 0.0
        }, completion: completion)
    }

}
