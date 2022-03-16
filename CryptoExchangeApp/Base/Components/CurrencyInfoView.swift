//
//  CurrencyInfoView.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 15/03/2022.
//
import UIKit

final class CurrencyInfoView: UIView {
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        
        let border = CALayer()
        border.backgroundColor = UIColor.red.cgColor
        border.frame = CGRect(x: 0, y: stack.bounds.size.height, width: stack.bounds.size.width, height: 1)
        stack.layer.addSublayer(border)
        return stack
    }()
    
    private lazy var supportStack = UIStackView()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .fontColor
        return label
    }()
    
    private lazy var percentageChangeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.addSubview(mainStack)
        mainStack.addArrangedSubview(titleLabel)
        mainStack.addArrangedSubview(supportStack)
        supportStack.addArrangedSubview(valueLabel)
        supportStack.addArrangedSubview(UIView())
        supportStack.addArrangedSubview(percentageChangeLabel)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: self.topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func configureViewWith(title: String, value: Double, percentageChange: Double?) {
        titleLabel.text = title
        
        let valueString = (round(value * 100) / 100).formattedWithSeparator
        valueLabel.text = valueString + " PLN"
        
        if let percentageChange = percentageChange {
            let percentageString = String(format: "%.2f", percentageChange)
            percentageChangeLabel.text = percentageString + "%"
            percentageChangeLabel.textColor = (percentageChange > 0) ? .appGreenColor : .appRedColor
        }
    }
}
