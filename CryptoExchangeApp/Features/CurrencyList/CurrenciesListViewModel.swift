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
    private var currentPage = 1
    var fetchMoreFlag = true
    
    let downloadingState = PublishRelay<DownloadingStates>()
    let currencies = BehaviorRelay<[Currency]>(value: [])
    
    func fetchCurrencies(page: Int = 1) {
        if currentPage == 1 {
            downloadingState.accept(.isLoading)
        }
        
        let currentCurrencies = currencies.value
        let observable: Observable<[Currency]> = NetworkEngine.downloadData(endpoint: CurrencyEndpoint.fetchCurrencies(page: page))
        
        observable
            .subscribe(onNext: { response in
                DispatchQueue.main.async { [weak self] in
                    self?.currencies.accept(currentCurrencies + response)
                    self?.fetchMoreFlag = true
                    self?.downloadingState.accept(.success)
                    print(self?.currencies.value.count ?? 0)
                }
            }, onError: { [weak self] error in
                self?.downloadingState.accept(.failure(error: error))
            })
            .disposed(by: disposeBag)
    }
    
    func refreshCurrencies() {
        currencies.accept([])
        fetchCurrencies(page: 1)
        currentPage = 1
    }
    
    func loadNextPage() {
        currentPage += 1
        fetchCurrencies(page: currentPage)
    }
}
