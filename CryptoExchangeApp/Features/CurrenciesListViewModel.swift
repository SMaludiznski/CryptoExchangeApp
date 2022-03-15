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
    var fetchMoreFlag = true
    private var currentPage = 1
    
    func fetchCurrencies() {
        downloadingState.accept(.isLoading)
        let observable: Observable<[Currency]> = NetworkEngine.downloadData(endpoint: CurrencyEndpoint.fetchCurrencies(page: currentPage))
        
        observable
            .subscribe(onNext: { response in
                DispatchQueue.main.async { [weak self] in
                    self?.currencies.accept(response)
                    self?.downloadingState.accept(.success)
                }
            }, onError: { [weak self] error in
                self?.downloadingState.accept(.failure(error: error))
            })
            .disposed(by: disposeBag)
    }
    
    func refreshCurrencies() {
        currentPage = 1
        fetchCurrencies()
    }
    
    func fetchMoreCurrencies() {
        currentPage += 1
        let observable: Observable<[Currency]> = NetworkEngine.downloadData(endpoint: CurrencyEndpoint.fetchCurrencies(page: currentPage))
        
        observable
            .subscribe(onNext: { response in
                let actualCurrencies = self.currencies.value
                self.currencies.accept(actualCurrencies + response)
                self.fetchMoreFlag = true
            }, onError: { [weak self] error in
                self?.currentPage -= 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self?.fetchMoreFlag = true
                }
            })
            .disposed(by: disposeBag)
    }
}
