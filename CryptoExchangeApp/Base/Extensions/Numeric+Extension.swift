//
//  Numeric+Extension.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 10/03/2022.
//

import Foundation

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}
