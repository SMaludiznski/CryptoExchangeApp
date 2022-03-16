//
//  AppCoordinator.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 08/03/2022.
//

import Foundation
import UIKit

protocol HomeCoordinator {
    func openDetailView(of currency: Currency)
}

final class AppCoordinator: Coordinator, HomeCoordinator {
    var children: [Coordinator] = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = HomeViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func openDetailView(of currency: Currency) {
//        let vc = CurrencyDetailViewController()
        let vc = CurrencyDetailsViewController()
        vc.configureView(with: currency)
        navigationController.pushViewController(vc, animated: true)
    }
}
