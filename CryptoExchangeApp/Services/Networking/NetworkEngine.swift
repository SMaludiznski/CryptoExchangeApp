//
//  NetworkEngine.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 11/03/2022.
//

import Foundation
import RxSwift

final class NetworkEngine {

    static func downloadData<T: Decodable>(endpoint: Endpoint) -> Observable<T> {
        
        return Observable.create { observer -> Disposable in
            
            do {
                let urlRequest = try APIRequest.request(from: endpoint)
                
                URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                    if error != nil {
                        print("error!")
                        observer.onError(NetworkingErrors.downloadingError)
                        return
                    }
                    
                    guard let response = response as? HTTPURLResponse,
                          response.statusCode >= 200 && response.statusCode < 300 else {
                              observer.onError(NetworkingErrors.wrongServerResponse)
                              return
                          }
                    
                    guard let data = data else {
                        observer.onError(NetworkingErrors.downloadingError)
                        return
                    }
                    
                    DispatchQueue.global(qos: .background).async {
                        do {
                            let decodedData: T = try ParseDataEngine.parseData(data)
                            observer.onNext(decodedData)
                            //observer.onError(NetworkingErrors.downloadingError)
                        } catch {
                            observer.onError(NetworkingErrors.decodingError)
                        }
                    }
                }
                .resume()
                
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
}
