//
//  CoinNameView.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 09/03/2022.
//

import UIKit

final class CoinNameView: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.numberOfLines = 0
        self.font = .systemFont(ofSize: 16, weight: .semibold)
        self.textColor = .fontColor
        self.widthAnchor.constraint(equalToConstant: 130).isActive = true
    }
    
    func configureViewWith(name: String, symbol: String) {
        let text = "\(name) \n\(symbol.uppercased())"
        let attributedText = NSMutableAttributedString(string: text)
        
        let font: UIFont = .systemFont(ofSize: 12, weight: .semibold)
        let color: UIColor = .lightGray
        attributedText.setAttributes([.font: font, .foregroundColor: color], range: NSRange(location: name.count + 1, length: symbol.count + 1))
        self.attributedText = attributedText
    }
}
