//
//  CurrencyEndpoint.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 11/03/2022.
//

import Foundation

enum CurrencyEndpoint: Endpoint {
    case fetchCurrencies(page: Int)
    case fetchCurrencyDetails(id: String)
    
    var scheme: String {
        return "https"
    }
    
    var baseURL: String {
        return "api.coingecko.com"
    }
    
    var path: String {
        switch self {
        case .fetchCurrencies(_):
            return "/api/v3/coins/markets"
        case .fetchCurrencyDetails(let id):
            return "/api/v3/coins/\(id)"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .fetchCurrencies(let page):
            return[URLQueryItem(name: "vs_currency", value: "pln"),
                   URLQueryItem(name: "order", value: "market_cap_desc"),
                   URLQueryItem(name: "per_page", value: "100"),
                   URLQueryItem(name: "page", value: String(page)),
                   URLQueryItem(name: "sparkline", value: "true"),
                   URLQueryItem(name: "price_change_percentage", value: "7d"),]
            
        case .fetchCurrencyDetails(_):
            return[URLQueryItem(name: "localization", value: "false"),
                   URLQueryItem(name: "tickers", value: "false"),
                   URLQueryItem(name: "market_data", value: "true"),
                   URLQueryItem(name: "community_data", value: "false"),
                   URLQueryItem(name: "developer_data", value: "false"),
                   URLQueryItem(name: "sparkline", value: "true")]
        }
    }
    
    var method: String {
        return "GET"
    }
}
