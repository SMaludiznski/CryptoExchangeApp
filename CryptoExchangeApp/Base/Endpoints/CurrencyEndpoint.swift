//
//  CurrencyEndpoint.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 11/03/2022.
//

import Foundation

enum CurrencyEndpoint: Endpoint {
case fetchCurrencies
    
    var scheme: String {
        return "https"
    }
    
    var baseURL: String {
        return "api.coingecko.com"
    }
    
    var path: String {
        return "/api/v3/coins/markets"
    }
    
    var parameters: [URLQueryItem] {
        return[URLQueryItem(name: "vs_currency", value: "pln"),
               URLQueryItem(name: "order", value: "market_cap_desc"),
               URLQueryItem(name: "per_page", value: "100"),
               URLQueryItem(name: "page", value: "1"),
               URLQueryItem(name: "sparkline", value: "true"),
               URLQueryItem(name: "price_change_percentage", value: "7d"),]
    }
    
    var method: String {
        return "GET"
    }
}
