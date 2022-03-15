//
//  CurrencyDetailViewModel.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 14/03/2022.
//

import Foundation
import RxSwift
import RxRelay

final class CurrencyDetailViewModel {
    let disposeBag = DisposeBag()
    let downloadingState = PublishRelay<DownloadingStates>()
    let currencyDetail = PublishRelay<CurrencyDetail>()
    
    func fetchCurrencies(id: String) {
        downloadingState.accept(.isLoading)
        let observable: Observable<CurrencyDetail> = NetworkEngine.downloadData(endpoint: CurrencyEndpoint.fetchCurrencyDetails(id: id))
        
        observable
            .subscribe(onNext: { [weak self] currency in
                DispatchQueue.main.async {
                    self?.currencyDetail.accept(currency)
                    self?.downloadingState.accept(.success)
                }
            }, onError: { [weak self] error in
                self?.downloadingState.accept(.failure(error: error))
            })
            .disposed(by: disposeBag)
    }
}
