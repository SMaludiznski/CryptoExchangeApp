//
//  CurrencyMarketData.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 14/03/2022.
//

import Foundation

struct CurrencyMarketData: Decodable {
    let currentPrice: CurrencyCurrentPrice
    let pricePercentage24h: Double
    let marketCap: [String: Double]
    let marketCapPercentage24h: Double
    let highPrice24h: [String: Double]
    let lowPrice24h: [String: Double]
    let sparkline: Price
    
    let athPrice: [String: Double]
    let athPercentage24h: [String: Double]
    let athDate: [String: String]
    let atlPrice: [String: Double]
    let atlPercentage24h: [String: Double]
    let atlDate: [String: String]
    
    private enum CodingKeys: String, CodingKey {
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapPercentage24h = "market_cap_change_percentage_24h"
        case pricePercentage24h = "price_change_percentage_24h"
        case highPrice24h = "high_24h"
        case lowPrice24h = "low_24h"
        case sparkline = "sparkline_7d"
        
        case athPrice = "ath"
        case athPercentage24h = "ath_change_percentage"
        case athDate = "ath_date"
        
        case atlPrice = "atl"
        case atlPercentage24h = "atl_change_percentage"
        case atlDate = "atl_date"
    }
}
