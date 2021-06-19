//
//  massage.swift
//  VK1_App
//
//  Created by Анатолий Левин on 09.04.2021.
//

import UIKit

class Massage: UIControl {
    
    let buttonMassage = UIButton()
    let labelMassage = UILabel()
    var stack = UIStackView()
    var selectedButton = false
    var countMassage = 0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stack.frame = bounds
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        massage()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        massage()
}
    func massage() {
        buttonMassage.setImage(UIImage(systemName: "bubble.left"), for: .normal)
        buttonMassage.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        buttonMassage.tintColor = .gray
        labelMassage.text = "\(countMassage)"
        labelMassage.textColor = .gray
        
        stack.addArrangedSubview(buttonMassage)
        stack.spacing = 1
        stack.addArrangedSubview(labelMassage)
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        self.addSubview(stack)
    }
    
    @objc func buttonAction (_ sender: UIButton) {
        
        func animation() {
            let animation = CASpringAnimation(keyPath: "transform.scale")
            animation.fromValue = 0.9
            animation.toValue = 1.1
            animation.stiffness = 200
            animation.mass = 2
            animation.duration = 0.5
            
            self.buttonMassage.layer.add(animation, forKey: nil)
        }
        
        if selectedButton == false {
            buttonMassage.setImage(UIImage(systemName: "bubble.left.fill"), for: .normal)
            buttonMassage.tintColor = .red
            countMassage += 2
            labelMassage.text = "\(countMassage)"
            labelMassage.textColor = .red
            selectedButton = true
            UIView.transition(with: labelMassage, duration: 0.35, options: .transitionFlipFromBottom, animations: { self.buttonMassage.setImage(UIImage(systemName: "bubble.left.fill"), for: .normal) })
            animation()
        }else{
            buttonMassage.setImage(UIImage(systemName: "bubble.left"), for: .normal)
            buttonMassage.tintColor = .gray
            countMassage -= 1
            labelMassage.text = "\(countMassage)"
            labelMassage.textColor = .gray
            selectedButton = false
            UIView.transition(with: labelMassage, duration: 0.35, options: .transitionFlipFromBottom, animations: { self.buttonMassage.setImage(UIImage(systemName: "bubble.left"), for: .normal) })
            animation()
        }
   }
}

