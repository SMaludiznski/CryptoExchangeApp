//
//  SearchBarView.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 08/03/2022.
//

import UIKit

final class SearchBarView: UIView {
    
    lazy var searchField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = .systemFont(ofSize: 20)
        field.leftImage(UIImage(systemName: "magnifyingglass"), imageWidth: 30, padding: 5)
        return field
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        configureView()
        self.addSubview(searchField)
        
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: self.topAnchor),
            searchField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            searchField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            searchField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            searchField.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func configureView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.5
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        self.tintColor = .fontColor
    }
}
