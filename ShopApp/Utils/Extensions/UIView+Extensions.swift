//
//  UIView+Extensions.swift
//  ShopApp
//
//  Created by Andres Felipe Rojas R. on 27/03/21.
//

import UIKit

extension UIView {

    func fadeIn(_ duration: TimeInterval = 0.5,
                delay: TimeInterval = 0.0,// swiftlint:disable:next unused_closure_parameter
                completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)  }

    func fadeOut(_ duration: TimeInterval = 0.5,
                 delay: TimeInterval = 0.0,// swiftlint:disable:next unused_closure_parameter
                 completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }

}
