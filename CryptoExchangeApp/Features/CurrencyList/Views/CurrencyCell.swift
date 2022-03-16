//
//  CurrencyCell.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 08/03/2022.
//

import UIKit
import RxCocoa

final class CurrencyCell: UITableViewCell {
    static let identifier = "CurrencyCell"
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .cellBackgroundColor
        stack.layer.cornerRadius = 10
        stack.spacing = 10
        stack.clipsToBounds = true
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return stack
    }()
    
    private lazy var rankLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return label
    }()
    
    private lazy var coinIcon = CoinIconView()
    private lazy var nameLabel = CoinNameView()
    private lazy var infoLabel = CoinInfoView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        contentView.addSubview(mainStack)
        mainStack.addArrangedSubview(rankLabel)
        mainStack.addArrangedSubview(coinIcon)
        mainStack.addArrangedSubview(nameLabel)
        mainStack.addArrangedSubview(UIView())
        mainStack.addArrangedSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7),
        ])
    }
    
    func configureCell(with currency: Currency) {
        coinIcon.loadImage(from: currency.image)
        rankLabel.text = String(currency.rank)
        nameLabel.configureViewWith(name: currency.name, symbol: currency.symbol)
        infoLabel.configureViewWith(price: currency.currentPrice, priceChange: currency.percentageDayChange ?? 0)
    }
}
