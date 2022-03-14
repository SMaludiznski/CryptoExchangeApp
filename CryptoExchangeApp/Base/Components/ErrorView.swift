//
//  ErrorView.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 11/03/2022.
//

import UIKit

final class ErrorView: UIView {
    private var error: Error
    private var title: String?
    private var imageName: String
    private var buttonTitle: String
    private var handler: () -> ()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 15
        return stack
    }()
    
    private lazy var errorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .fontColor
        return imageView
    }()
    
    private lazy var errorTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var errorDescription: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .accentColor
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.tintColor = .white
        return button
    }()
    
    init(title: String?, error: Error, imageName: String, buttonTitle: String, handler: @escaping () -> ()) {
        self.title = title
        self.error = error
        self.imageName = imageName
        self.buttonTitle = buttonTitle
        self.handler = handler
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        configureErrorView()
        
        self.addSubview(errorImageView)
        self.addSubview(mainStack)
        mainStack.addArrangedSubview(errorTitle)
        mainStack.addArrangedSubview(errorDescription)
        mainStack.addArrangedSubview(actionButton)
        
        NSLayoutConstraint.activate([
            errorImageView.bottomAnchor.constraint(equalTo: mainStack.topAnchor, constant: -10),
            errorImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            errorImageView.widthAnchor.constraint(equalToConstant: 75),
            errorImageView.heightAnchor.constraint(equalToConstant: 75),
            
            mainStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mainStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainStack.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
        ])
    }
    
    private func configureErrorView() {
        if let image = UIImage(systemName: imageName) {
            errorImageView.image = image
        } else {
            errorImageView.image = UIImage(systemName: "exclamationmark.shield")
        }
        
        if let title = title {
            errorTitle.text = title
        }
        
        actionButton.setTitle(buttonTitle, for: .normal)
        actionButton.addTarget(self, action: #selector(errorAction), for: .touchUpInside)
        errorDescription.text = error.localizedDescription
    }
    
    @objc private func errorAction() {
        handler()
    }
}
