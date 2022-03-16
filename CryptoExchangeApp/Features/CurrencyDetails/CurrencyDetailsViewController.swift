//
//  CurrencyDetailsViewController.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 16/03/2022.
//

import UIKit
import RxCocoa
import RxSwift


final class CurrencyDetailsViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let vm = CurrencyDetailsViewModel()
    private var currentCurrency: Currency? = nil
    
    private lazy var container = UIViewController()
    
    deinit {
        print("View Controller deinit")
    }
    
    override func loadView() {
        super.loadView()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .backgroundColor
        
        addChild(container)
        didMove(toParent: container)
        view.addSubview(container.view)
        
        NSLayoutConstraint.activate([
            container.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            container.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            container.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func configureView(with currency: Currency) {
        currentCurrency = currency
        bindUI()
        vm.fetchDetails(currency: currency)
    }
}

//MARK: - Bind UI
extension CurrencyDetailsViewController {
    private func bindUI() {
        vm.state
            .subscribe(onNext: { [weak self] state in
                self?.viewSwitcher(state: state)
            })
            .disposed(by: disposeBag)
    }
    
    private func viewSwitcher(state: DownloadingStates) {
        DispatchQueue.main.async {
            switch state {
            case .success:
                if let currency = self.vm.currencyDetails.value {
                    self.navigationItem.titleView = TitleLabel(title: currency.name)
                    self.container.view = DetailsView(currencyDetails: currency)
                }
            case .isLoading:
                self.container.view = LoadingView()
            case .failure(let error):
                self.container.view = ErrorView(title: "Error", error: error, imageName: "", buttonTitle: "Refresh", handler: {
                    if let currentCurrency = self.currentCurrency {
                        self.configureView(with: currentCurrency)
                    } else {
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                })
            }
        }
    }
}
