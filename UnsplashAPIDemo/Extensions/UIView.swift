//
//  UIView.swift
//  UnsplashAPIDemo
//
//  Created by Apple on 4/26/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

extension UIView {
    func corner(_ radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }

    func border(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }

    func addConstraint(top: NSLayoutYAxisAnchor? = nil, topConstant: CGFloat = 0, leading: NSLayoutXAxisAnchor? = nil, leadingConstant: CGFloat = 0, bottom: NSLayoutYAxisAnchor? = nil, bottomConstant: CGFloat = 0, trailing: NSLayoutXAxisAnchor? = nil, trailingConstant: CGFloat = 0, centerX: NSLayoutXAxisAnchor? = nil, centerXConstant: CGFloat = 0, centerY: NSLayoutYAxisAnchor? = nil, centerYConstant: CGFloat = 0, width: NSLayoutDimension? = nil, widthMultiplier: CGFloat = 1, widthConstant: CGFloat? = nil, height: NSLayoutDimension? = nil, heightMultiplier: CGFloat = 1, heightConstant: CGFloat? = nil) {
        if let topAnchor = top {
            self.topAnchor.constraint(equalTo: topAnchor, constant: topConstant).isActive = true
        }
        if let leadingAnchor = leading {
            self.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingConstant).isActive = true
        }
        if let bottomAnchor = bottom {
            self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: bottomConstant).isActive = true
        }
        if let trailingAnchor = trailing {
            self.trailingAnchor.constraint(equalTo: trailingAnchor, constant: trailingConstant).isActive = true
        }
        if let widthAnchor = width {
            self.widthAnchor.constraint(equalTo: widthAnchor, multiplier: widthMultiplier).isActive = true
        }
        if let widthConstant = widthConstant {
            widthAnchor.constraint(equalToConstant: widthConstant).isActive = true
        }
        if let heightAnchor = height {
            self.heightAnchor.constraint(equalTo: heightAnchor, multiplier: heightMultiplier).isActive = true
        }
        if let heightConstant = heightConstant {
            heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
        }
    }
}
