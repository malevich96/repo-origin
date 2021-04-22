//
//  ViewWithShadow.swift
//  VK1_App
//
//  Created by Анатолий Левин on 16.03.2021.
//

import UIKit

@IBDesignable class ViewWithShadow: UIView {
    
    @IBInspectable var shadowColor: UIColor = .black {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.5 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 8 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 2, height: 2) {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
}
