//
//  FiltersStates.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 14/03/2022.
//

import Foundation

enum FiltersStates: CaseIterable {
    case none
    case priceAscending
    case priceDescending
    case percentageAscending
    case percentageDescending
    
    var filterTitle: String {
        switch self {
        case .none:
            return "None"
        case .priceAscending:
            return "Price - ascending"
        case .priceDescending:
            return "Price - descending"
        case .percentageAscending:
            return "Percentage change - ascending"
        case .percentageDescending:
            return "Percentage change - descending"
        }
    }
    
    var filterIcon: String {
        switch self {
        case .none:
            return "minus.rectangle"
        case .priceAscending:
            return "arrowtriangle.up"
        case .priceDescending:
            return "arrowtriangle.down"
        case .percentageAscending:
            return "arrowtriangle.up.fill"
        case .percentageDescending:
            return "arrowtriangle.down.fill"
        }
    }
    
    func filterLogic(firstCurrency: Currency, secondCurrency: Currency) -> Bool {
        switch self {
        case .none:
            return false
        case .priceAscending:
            return firstCurrency.currentPrice < secondCurrency.currentPrice
        case .priceDescending:
            return firstCurrency.currentPrice > secondCurrency.currentPrice
        case .percentageAscending:
            if let firstCurrencyPercenteageDayChange = firstCurrency.percentageDayChange,
               let secondCurrencyPercenteageDayChange = secondCurrency.percentageDayChange {
                return firstCurrencyPercenteageDayChange < secondCurrencyPercenteageDayChange
            } else {
                return false
            }
        
        case .percentageDescending:
            if let firstCurrencyPercenteageDayChange = firstCurrency.percentageDayChange,
               let secondCurrencyPercenteageDayChange = secondCurrency.percentageDayChange {
                return firstCurrencyPercenteageDayChange > secondCurrencyPercenteageDayChange
            } else {
                return false
            }
        }
    }
}
