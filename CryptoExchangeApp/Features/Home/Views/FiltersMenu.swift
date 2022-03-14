//
//  FiltersMenu.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 11/03/2022.
//

import UIKit
import RxSwift
import RxRelay

final class FiltersMenu: UIView, UIContextMenuInteractionDelegate {
    let filterState = PublishRelay<FiltersStates>()
    
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
        configureView()
        
        NSLayoutConstraint.activate([
            filtersButton.widthAnchor.constraint(equalToConstant: 25),
            filtersButton.heightAnchor.constraint(equalToConstant: 25),
            filtersButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            filtersButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func configureView() {
        self.addSubview(filtersButton)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.backgroundColor = .backgroundColor
    }
}

//MARK: - Set up context menu
extension FiltersMenu {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedActions in
            var menuActions = [UIAction]()
            
            for filter in FiltersStates.allCases {
                let action = UIAction(title: filter.filterTitle, image: UIImage(systemName: filter.filterIcon)) { action in
                    self.filterState.accept(filter)
                }
                menuActions.append(action)
            }
            
            return UIMenu(title: "Filters", image: UIImage(systemName: "slider.horizontal.3"), children: menuActions)
        })
    }
}
