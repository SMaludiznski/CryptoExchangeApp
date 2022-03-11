//
//  Formatter+Extension.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 10/03/2022.
//

import Foundation

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }()
}
