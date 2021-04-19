//
//  imageWithShadow.swift
//  VK1_App
//
//  Created by Анатолий Левин on 19.03.2021.
//

import UIKit
    
class ImageWithShadow: UIView {
    
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
    
    @IBInspectable var image: UIImage? = nil {
        didSet {
            imageView.image = image
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            imageView.layer.masksToBounds = cornerRadius > 0
            imageView.layer.cornerRadius = cornerRadius
        }
    }
    
    var imageView = UIImageView()
    
  override  init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
}

