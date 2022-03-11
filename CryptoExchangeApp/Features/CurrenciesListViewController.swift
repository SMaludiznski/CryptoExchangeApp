//
//  CurrenciesListViewController.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 08/03/2022.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

final class CurrenciesListViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let vm = CurrenciesListViewModel()
    let query = BehaviorRelay<String>(value: "")
    
    private lazy var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm.fetchCurrencies()
    }
    
    override func loadView() {
        super.loadView()
        bindUI()
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.showsVerticalScrollIndicator = false
        tableView.register(CurrencyCell.self, forCellReuseIdentifier: CurrencyCell.identifier)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func refresh() {
        vm.fetchCurrencies()
    }
}

extension CurrenciesListViewController {
    private func bindUI() {
        vm.isLoading
            .subscribe(onNext: { isLoading in
                switch (isLoading) {
                case true:
                    self.view = LoadingView()
                case false:
                    self.view = self.tableView
                }
            })
            .disposed(by: disposeBag)
        
        Observable.combineLatest(vm.currencies.asObservable(), query) { currencies, query in
            currencies.filter({ currency in
                query.isEmpty || currency.name.lowercased().contains(query.lowercased()) || currency.symbol.lowercased().contains(query.lowercased())
            })
        }
        .bind(to: tableView.rx.items(cellIdentifier: CurrencyCell.identifier, cellType: CurrencyCell.self)) { row, currency, cell in
            cell.configureCell(with: currency)
        }
        .disposed(by: disposeBag)
    }
}
