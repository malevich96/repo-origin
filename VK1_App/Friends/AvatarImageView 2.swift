//
//  RoundedImageView.swift
//  VK1_App
//
//  Created by Анатолий Левин on 19.03.2021.
//

import UIKit

//@IBDesignable class RoundedImageView: UIImageView {
    
//    @IBInspectable var cornerRadius: CGFloat = 0 {
//        didSet {
//            layer.masksToBounds = cornerRadius > 0
//            layer.cornerRadius = cornerRadius
//        }
//    }
//}

class AvatarImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        UIView.animate(withDuration: 0.3, delay: 0, options: [.allowUserInteraction]) {
            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        } completion: { complection in
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        UIView.animate(withDuration: 0.3, delay: 0, options: [.allowUserInteraction]) {
            self.transform = .identity
        } completion: { complection in
            
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        UIView.animate(withDuration: 0.3, delay: 0, options: [.allowUserInteraction]) {
            self.transform = .identity
        } completion: { complection in
            
        }
    }
}
