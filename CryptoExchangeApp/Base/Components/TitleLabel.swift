//
//  TitleLabel.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 14/03/2022.
//

import UIKit

final class TitleLabel: UILabel {

    private let title: String
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.text = self.title
        self.font = .systemFont(ofSize: 21, weight: .bold)
        self.textColor = .fontColor
    }
}
