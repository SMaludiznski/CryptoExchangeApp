//
//  DownloadingStates.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 14/03/2022.
//

import Foundation

enum DownloadingStates {
    case success
    case failure(error: Error)
    case isLoading
}
