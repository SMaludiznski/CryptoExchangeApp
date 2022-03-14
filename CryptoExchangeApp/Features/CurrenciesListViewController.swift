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
    let filterState = BehaviorRelay<FiltersStates>(value: .none)
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

//MARK: - Bind UI
extension CurrenciesListViewController {
    private func bindUI() {
        vm.downloadingState
            .subscribe(onNext: { state in
                switch state {
                case .isLoading:
                    self.view = LoadingView()
                case .success:
                    self.view = self.tableView
                case .failure(error: let error):
                    self.view = ErrorView(title: "Networking error", error: error, imageName: "", buttonTitle: "Refresh", handler: {
                        self.vm.fetchCurrencies()
                    })
                }
            })
            .disposed(by: disposeBag)
        
        Observable.combineLatest(vm.currencies.asObservable(), query, filterState) { currencies, query, _ in
            currencies.filter({ currency in
                query.isEmpty || currency.name.lowercased().contains(query.lowercased()) || currency.symbol.lowercased().contains(query.lowercased())
            })
        }
        .map({ currencies in
            return currencies.sorted { (firstCurrency, secondCurrency) -> Bool in
                return self.filterState.value.filterLogic(firstCurrency: firstCurrency, secondCurrency: secondCurrency)
            }
        })
        .bind(to: tableView.rx.items(cellIdentifier: CurrencyCell.identifier, cellType: CurrencyCell.self)) { row, currency, cell in
            cell.configureCell(with: currency)
        }
        .disposed(by: disposeBag)
        
        tableView.rx.contentOffset
            .subscribe(onNext: { value in
                let offsetY = self.tableView.contentOffset.y
                let contentHeight = self.tableView.contentSize.height
                
                if offsetY > contentHeight - (2 * self.tableView.frame.height) {
                    if self.vm.fetchMoreFlag {
                        self.vm.fetchMoreFlag = false
                        self.vm.fetchMoreCurrencies()
                    }
                }
            })
            .disposed(by: disposeBag)
    }
}
