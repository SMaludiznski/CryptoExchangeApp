//
//  HomeViewController.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 08/03/2022.
//

import UIKit
import RxSwift
import RxCocoa

final class HomeViewController: UIViewController {
    private let disposeBag = DisposeBag()
    var coordinator: HomeCoordinator?
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    private lazy var searchStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 5
        return stack
    }()
    
    private lazy var titleLabel = TitleLabel(title: "Live prices")
    private lazy var searchBarView = SearchBarView()
    private lazy var filtersMenu = FiltersMenu()
    private lazy var currenciesList = CurrenciesListViewController()
    
    override func loadView() {
        super.loadView()
        setupView()
    }
    
    private func setupView() {
        bindUI()
        setupNavBar()
        view.backgroundColor = .backgroundColor
        
        let menuInteraction = UIContextMenuInteraction(delegate: filtersMenu)
        filtersMenu.addInteraction(menuInteraction)
        
        addChild(currenciesList)
        didMove(toParent: self)
        
        view.addSubview(mainStack)
        mainStack.addArrangedSubview(searchStack)
        searchStack.addArrangedSubview(searchBarView)
        searchStack.addArrangedSubview(filtersMenu)
        
        mainStack.addArrangedSubview(UIView())
        mainStack.addArrangedSubview(currenciesList.view)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            mainStack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            filtersMenu.widthAnchor.constraint(equalToConstant: 40),
            searchStack.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupNavBar() {
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.tintColor = .fontColor
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshCurrencies))
    }
    
    @objc private func refreshCurrencies() {
        currenciesList.refresh()
    }
}

//MARK: - Bind UI
extension HomeViewController {
    private func bindUI() {
        searchBarView.searchField.rx.text.orEmpty
            .bind(to: self.currenciesList.query)
            .disposed(by: disposeBag)
        
        filtersMenu.filterState
            .subscribe(onNext: { filter in
                self.currenciesList.filterState.accept(filter)
            })
            .disposed(by: disposeBag)
        
        currenciesList.selectedCurrency
            .subscribe(onNext: { [weak self] currency in
                self?.coordinator?.openDetailView(of: currency)
            })
            .disposed(by: disposeBag)
    }
}
