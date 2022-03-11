//
//  APIRequest.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 11/03/2022.
//

import Foundation

final class APIRequest {
    
    static func request(from endpoint: Endpoint) throws -> URLRequest {
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.parameters
        
        guard let url = components.url else {
            throw NetworkingErrors.wrongURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method
        
        return urlRequest
    }
}
