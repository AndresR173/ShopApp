//
//  UIFont+Extensions.swift
//  ShopApp
//
//  Created by Andres Felipe Rojas R. on 27/03/21.
//

import UIKit

enum MonserratFontWeight: String {
    case regular = "Montserrat-Regular"
    case bold = "Montserrat-Bold"
    case medium = "Montserrat-Medium"
    case semiBold = "Montserrat-SemiBold"
}

enum FontSize: CGFloat {

    case heading = 24
    case regular, buttonTextLarge = 18
    case cell, body = 16
    case buttonTextSmall = 15

}

extension UIFont {

    static func monserrat(_ weight: MonserratFontWeight, size: CGFloat) -> UIFont {
        return UIFont(name: weight.rawValue, size: size)!
    }

    static func monserrat(_ weight: MonserratFontWeight, size: FontSize) -> UIFont {
        return monserrat(weight, size: size.rawValue)
    }

}
