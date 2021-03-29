//
//  UIColor+Extensions.swift
//  ShopApp
//
//  Created by Andres Felipe Rojas R. on 27/03/21.
//

import UIKit

extension UIColor {
    /// This properties is used to determine when tu use white or black text color
    var isDarkColor: Bool {

        var r, g, b, a: CGFloat
        (r, g, b, a) = (0, 0, 0, 0)
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        let lum = 0.2126 * r + 0.7152 * g + 0.0722 * b

        return  lum < 0.50
    }
}
