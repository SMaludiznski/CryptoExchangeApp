//
//  CoinInfoView.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 09/03/2022.
//
import UIKit

final class CoinInfoView: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.numberOfLines = 0
        self.textColor = .fontColor
        self.textAlignment = .right
        self.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    
    func configureViewWith(price: Double, priceChange: Double) {
        let priceString = (round(price * 100) / 100).formattedWithSeparator
        let priceChangeString = String(format: "%.2f", priceChange)
        
        let text = "\(priceString) PLN \n\(priceChangeString)%"
        let attributedText = NSMutableAttributedString(string: text)
        
        let color: UIColor = (priceChange > 0) ? .appGreenColor ?? .black : .appRedColor ?? .black
        let font: UIFont = .systemFont(ofSize: 12, weight: .bold)
        
        attributedText.setAttributes([.font: font, .foregroundColor: color],
                                     range: NSRange(location: priceString.count + 5, length: priceChangeString.count + 2))
        
        self.attributedText = attributedText
    }
}
