//
//  CoinImageView.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 10/03/2022.
//

import UIKit

final class CoinIconView: UIView {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.sizeToFit()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 18
        imageView.backgroundColor = .cellBackgroundColor
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        let imageViewSize = 36.0
        self.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: imageViewSize),
            imageView.widthAnchor.constraint(equalToConstant: imageViewSize),
            imageView.heightAnchor.constraint(equalToConstant: imageViewSize),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func loadImage(from url: String) {
        imageView.loadImageFrom(url: url)
    }
}
