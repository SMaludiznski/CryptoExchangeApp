//
//  ParseDataEngine.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 11/03/2022.
//

import Foundation

final class ParseDataEngine {
    
    static func parseData<T: Decodable>(_ data: Data) throws -> T {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkingErrors.decodingError
        }
    }
}
