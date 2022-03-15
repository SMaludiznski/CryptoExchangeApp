//
//  CurrencyDetail.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 14/03/2022.
//

import Foundation

struct CurrencyDetail: Decodable {
    let symbol: String
    let name: String
    let marketData: CurrencyMarketData
    let marketCapRank: Int
    
    private enum CodingKeys: String, CodingKey {
        case symbol, name
        case marketData = "market_data"
        case marketCapRank = "market_cap_rank"
    }
}
