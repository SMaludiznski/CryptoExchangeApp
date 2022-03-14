//
//  CurrenciesListViewModel.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 08/03/2022.
//

import Foundation
import RxSwift
import RxRelay

final class CurrenciesListViewModel {
    private let disposeBag = DisposeBag()
    let downloadingState = PublishRelay<DownloadingStates>()
    let currencies = BehaviorRelay<[Currency]>(value: [])
    
    func fetchCurrencies() {
        downloadingState.accept(.isLoading)
        let observable: Observable<[Currency]> = NetworkEngine.downloadData(endpoint: CurrencyEndpoint.fetchCurrencies)
        
        observable
            .subscribe(onNext: { response in
                DispatchQueue.main.async { [weak self] in
                    self?.currencies.accept(response)
                    self?.downloadingState.accept(.success)
                }
            }, onError: { error in
                self.downloadingState.accept(.failure(error: error))
            })
            .disposed(by: disposeBag)
    }
}
