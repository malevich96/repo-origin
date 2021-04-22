//
//  LikeButton.swift
//  VK1_App
//
//  Created by Анатолий Левин on 19.03.2021.
//

import UIKit

class Like: UIControl {
    
    let buttonLike = UIButton()
    let labelLike = UILabel()
    var stack = UIStackView()
    var selectedButton = false
    var countLikes = 0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stack.frame = bounds
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        likes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        likes()
}
    func likes() {
        buttonLike.setImage(UIImage(systemName: "heart"), for: .normal)
        buttonLike.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        buttonLike.tintColor = .gray
        labelLike.text = "\(countLikes)"
        labelLike.textColor = .gray
        
        stack.addArrangedSubview(buttonLike)
        stack.spacing = 1
        stack.addArrangedSubview(labelLike)
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
            
            self.buttonLike.layer.add(animation, forKey: nil)
        }
        
        if selectedButton == false {
            buttonLike.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            buttonLike.tintColor = .red
            countLikes += 2
            labelLike.text = "\(countLikes)"
            labelLike.textColor = .red
            selectedButton = true
            UIView.transition(with: labelLike, duration: 0.35, options: .transitionFlipFromBottom, animations: { self.buttonLike.setImage(UIImage(systemName: "heart.fill"), for: .normal) })
            animation()
        }else{
            buttonLike.setImage(UIImage(systemName: "heart"), for: .normal)
            buttonLike.tintColor = .gray
            countLikes -= 1
            labelLike.text = "\(countLikes)"
            labelLike.textColor = .gray
            selectedButton = false
            UIView.transition(with: labelLike, duration: 0.35, options: .transitionFlipFromBottom, animations: { self.buttonLike.setImage(UIImage(systemName: "heart"), for: .normal) })
            animation()
        }
   }
}

