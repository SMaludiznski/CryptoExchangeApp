//
//  FiltersMenu.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 11/03/2022.
//

import UIKit

final class FiltersMenu: UIView, UIContextMenuInteractionDelegate {
    lazy var filtersButton: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "slider.horizontal.3")
        imageView.tintColor = .fontColor
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
        self.addSubview(filtersButton)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.backgroundColor = .backgroundColor
        
        let menuInteraction = UIContextMenuInteraction(delegate: self)
        filtersButton.addInteraction(menuInteraction)
        
        NSLayoutConstraint.activate([
            filtersButton.widthAnchor.constraint(equalToConstant: 25),
            filtersButton.heightAnchor.constraint(equalToConstant: 25),
            filtersButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            filtersButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func makeContextMenu() -> UIMenu {

        let priceAscending = UIAction(title: "Price - ascending", image: UIImage(systemName: "arrowtriangle.up")) { action in
            print("Up")
        }
        
        let priceDescending = UIAction(title: "Price - descending", image: UIImage(systemName: "arrowtriangle.down")) { action in
            print("Down")
        }
        
        let percentageAscending = UIAction(title: "Percentage change - ascending", image: UIImage(systemName: "arrowtriangle.up")) { action in
            print("Up")
        }
        
        let percentageDescending = UIAction(title: "Percentage change - descending", image: UIImage(systemName: "arrowtriangle.down")) { action in
            print("Down")
        }

        return UIMenu(title: "Filters",image: UIImage(systemName: "slider.horizontal.3"), children: [priceAscending, priceDescending, percentageAscending, percentageDescending])
    }
}

extension FiltersMenu {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {

        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedActions in

            return self.makeContextMenu()
        })
    }
}
