//
//  Animations.swift
//  VK1_App
//
//  Created by Анатолий Левин on 09.04.2021.
//

import Foundation
import UIKit

class Animations {
     
    public func fadeElement(_ element: UIView, duration: TimeInterval, delay: TimeInterval){
        UIView.animate(
            withDuration: duration,
            delay: delay,
            options: [.curveLinear, .repeat, .autoreverse],
            animations: {
                element.alpha = 0
    },
            completion: nil)
        
}
    public func increaseElemetOnTap(_ element: UIButton) {
       
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 1
        animation.autoreverses = true
        animation.fillMode = CAMediaTimingFillMode.backwards
        element.layer.add(animation, forKey: nil)
    }
    
    public func reactToClickOnAvatar(_ element: UIView){
        
        let  animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0.8
        animation.toValue = 1
        animation.duration = 2.5
        animation.stiffness = 180
        animation.mass = 2
        animation.fillMode = CAMediaTimingFillMode.backwards
        element.layer.add(animation, forKey: nil)
        
    }
}
