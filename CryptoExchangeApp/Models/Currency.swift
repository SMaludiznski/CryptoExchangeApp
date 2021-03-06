//
//  Currency.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 08/03/2022.
//

import Foundation

struct Currency: Decodable {
    let id: String
    let symbol: String
    let name: String
    let image: String
    let currentPrice: Double
    let rank: Int
    let percentageDayChange: Double?
    let priceValues: Price
    let percentageWeekChange: Double?
    
    private enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case rank = "market_cap_rank"
        case percentageDayChange = "price_change_percentage_24h"
        case priceValues = "sparkline_in_7d"
        case percentageWeekChange = "price_change_percentage_7d_in_currency"
    }
}
