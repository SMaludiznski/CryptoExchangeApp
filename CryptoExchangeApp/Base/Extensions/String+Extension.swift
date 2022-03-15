//
//  String+Extension.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 15/03/2022.
//

import Foundation

extension String {
    func dateFromString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let dateFromStr = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "MMM d, yyyy"
        
        if let date = dateFromStr {
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
}
