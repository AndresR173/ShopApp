//
//  Double+extensions.swift
//  ShopApp
//
//  Created by Andres Felipe Rojas R. on 28/03/21.
//

import Foundation

extension Double {

    var asCurrency: String {

        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 0
        let formattedNumber = numberFormatter.string(from: NSNumber(value: self))

        return formattedNumber ?? ""
    }
}
