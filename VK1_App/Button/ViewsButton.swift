//
//  ViewsButton.swift
//  VK1_App
//
//  Created by Анатолий Левин on 09.04.2021.
//

import UIKit

class ViewsButton: UIControl {
    
    let buttonViews = UIButton()
    let labelViews = UILabel()
    var stack = UIStackView()
    var selectedButton = false
    var countViews = 0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stack.frame = bounds
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        views()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        views()
}
    func views() {
        buttonViews.setImage(UIImage(systemName: "eye"), for: .normal)
        buttonViews.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        buttonViews.tintColor = .gray
        labelViews.text = "\(countViews)"
        labelViews.textColor = .gray
        
        stack.addArrangedSubview(buttonViews)
        stack.spacing = 1
        stack.addArrangedSubview(labelViews)
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
            
            self.buttonViews.layer.add(animation, forKey: nil)
        }
        
        if selectedButton == false {
            buttonViews.setImage(UIImage(systemName: "eye"), for: .normal)
            buttonViews.tintColor = .red
            countViews += 2
            labelViews.text = "\(countViews)"
            labelViews.textColor = .red
            selectedButton = true
            UIView.transition(with: labelViews, duration: 0.35, options: .transitionFlipFromBottom, animations: { self.buttonViews.setImage(UIImage(systemName: "eye"), for: .normal) })
            animation()
        }else{
            buttonViews.setImage(UIImage(systemName: "eye"), for: .normal)
            buttonViews.tintColor = .gray
            countViews -= 1
            labelViews.text = "\(countViews)"
            labelViews.textColor = .gray
            selectedButton = false
            UIView.transition(with: labelViews, duration: 0.35, options: .transitionFlipFromBottom, animations: { self.buttonViews.setImage(UIImage(systemName: "eye"), for: .normal) })
            animation()
        }
   }
}

