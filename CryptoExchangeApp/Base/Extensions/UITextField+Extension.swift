//
//  UITextField+Extensions.swift
//  CryptoExchangeApp
//
//  Created by Sebastian Maludziński on 08/03/2022.
//

import Foundation
import UIKit

extension UITextField {
    func leftImage(_ image: UIImage?, imageWidth: CGFloat, padding: CGFloat) {
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: imageWidth, height: frame.height)
        imageView.contentMode = .left
        imageView.tintColor = .fontColor
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: imageWidth + padding, height: frame.height))
        containerView.addSubview(imageView)
        leftView = containerView
        leftViewMode = .always
    }
}
