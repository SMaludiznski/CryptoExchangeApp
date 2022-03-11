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
    let isLoading = PublishRelay<Bool>()
    let currencies = BehaviorRelay<[Currency]>(value: [])
    
    func fetchCurrencies() {
        isLoading.accept(true)
        let observable: Observable<[Currency]> = NetworkEngine.downloadData(endpoint: CurrencyEndpoint.fetchCurrencies)
            
        observable
            .subscribe(onNext: { response in
                DispatchQueue.main.async { [weak self] in
                    self?.currencies.accept(response)
                    self?.isLoading.accept(false)
                }
            }, onError: { error in
                print(error)
                self.isLoading.accept(false)
            })
            .disposed(by: disposeBag)
    }
}
