//
//  LoadingView.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 08/03/2022.
//

import UIKit

final class LoadingView: UIView {
    
    private lazy var loadingSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(loadingSpinner)
        
        NSLayoutConstraint.activate([
            loadingSpinner.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            loadingSpinner.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
