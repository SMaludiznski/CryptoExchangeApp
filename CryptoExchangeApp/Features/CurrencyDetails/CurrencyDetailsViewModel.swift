//
//  CurrencyDetailsViewModel.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 16/03/2022.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

final class CurrencyDetailsViewModel {
    private let disposeBag = DisposeBag()
    let state = PublishRelay<DownloadingStates>()
    let currencyDetails = BehaviorRelay<CurrencyDetail?>(value: nil)
    
    deinit {
        print("View model deinit")
    }
    
    func fetchDetails(currency: Currency) {
        state.accept(.isLoading)
        let observable: Observable<CurrencyDetail> = NetworkEngine.downloadData(endpoint: CurrencyEndpoint.fetchCurrencyDetails(id: currency.id))
        
        observable
            .subscribe(onNext: { [weak self] currency in
                self?.currencyDetails.accept(currency)
                self?.state.accept(.success)
            }, onError: { [weak self] error in
                self?.state.accept(.failure(error: error))
            })
            .disposed(by: disposeBag)
    }
}
