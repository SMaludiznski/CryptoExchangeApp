//
//  CurrencyDetailViewController.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 14/03/2022.
//

import UIKit
import RxSwift
import RxCocoa

final class CurrencyDetailViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let vm = CurrencyDetailViewModel()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 15
        stack.axis = .vertical
        return stack
    }()
    
    private lazy var chartView = ChartView()
    private lazy var chartContainer: UIStackView = {
        let stack = UIStackView()
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        stack.clipsToBounds = true
        stack.layer.cornerRadius = 10
        stack.backgroundColor = .chartBackgroundColor
        return stack
    }()
    
    private lazy var currentPriceLabel = CurrencyInfoView()
    private lazy var lowPrice24hLabel = CurrencyInfoView()
    private lazy var highPrice24hLabel = CurrencyInfoView()
    private lazy var athLabel = CurrencyInfoView()
    private lazy var atlLabel = CurrencyInfoView()
    private lazy var marketCapLabel = CurrencyInfoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        setupView()
    }
    
    private func setupView() {
        bindUI()
        view.backgroundColor = .backgroundColor
        
        view.addSubview(mainStack)
        mainStack.addArrangedSubview(chartContainer)
        chartContainer.addArrangedSubview(chartView)
        
        mainStack.addArrangedSubview(currentPriceLabel)
        mainStack.addArrangedSubview(athLabel)
        mainStack.addArrangedSubview(atlLabel)
        mainStack.addArrangedSubview(marketCapLabel)
        mainStack.addArrangedSubview(lowPrice24hLabel)
        mainStack.addArrangedSubview(highPrice24hLabel)
        mainStack.addArrangedSubview(UIView())
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            mainStack.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            chartView.heightAnchor.constraint(equalTo: chartView.widthAnchor, multiplier: 0.4)
        ])
    }
    
    func configureView(with currency: Currency) {
        vm.fetchCurrencies(id: currency.id)
        
        navigationItem.titleView = TitleLabel(title: currency.name)
        chartView.fillChartWith(data: currency.priceValues.price, isPositive: currency.percentageWeekChange ?? -1 > 0)
    }
    
    private func configureCurrencyDetails(with currency: CurrencyDetail) {        
        currentPriceLabel.configureViewWith(title: "Price",
                                            value: currency.marketData.currentPrice.pln,
                                            percentageChange: currency.marketData.pricePercentage24h)
        
        lowPrice24hLabel.configureViewWith(title: "Lowest price at last 24 h",
                                           value: currency.marketData.lowPrice24h["pln"] ?? 0,
                                           percentageChange: nil)
        
        highPrice24hLabel.configureViewWith(title: "Highest price at last 24 h",
                                            value: currency.marketData.highPrice24h["pln"] ?? 0,
                                            percentageChange: nil)
        
        athLabel.configureViewWith(title: "All Time High (\(currency.marketData.athDate["pln"]?.dateFromString() ?? ""))",
                                   value: currency.marketData.athPrice["pln"] ?? 0,
                                   percentageChange: currency.marketData.athPercentage24h["pln"] ?? 0)
        
        atlLabel.configureViewWith(title: "All Time Low (\(currency.marketData.atlDate["pln"]?.dateFromString() ?? ""))",
                                   value: currency.marketData.atlPrice["pln"] ?? 0,
                                   percentageChange: currency.marketData.atlPercentage24h["pln"] ?? 0)
        
        marketCapLabel.configureViewWith(title: "Market Cap",
                                         value: currency.marketData.marketCap["pln"] ?? 0,
                                         percentageChange: currency.marketData.marketCapPercentage24h)
    }
}

//MARK: - Bind UI
extension CurrencyDetailViewController {
    private func bindUI() {
        vm.currencyDetail
            .subscribe(onNext: { [weak self] currency in
                self?.configureCurrencyDetails(with: currency)
            })
            .disposed(by: disposeBag)
    }
}
