//
//  repost.swift
//  VK1_App
//
//  Created by Анатолий Левин on 09.04.2021.
//

import UIKit

class RepostButton: UIControl {
    
    let buttonRepost = UIButton()
    let labelRepost = UILabel()
    var stack = UIStackView()
    var selectedButton = false
    var countRepost = 0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stack.frame = bounds
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        repost()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        repost()
}
    func repost() {
        buttonRepost.setImage(UIImage(systemName: "arrowshape.turn.up.forward"), for: .normal)
        buttonRepost.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        buttonRepost.tintColor = .gray
        labelRepost.text = "\(countRepost)"
        labelRepost.textColor = .gray
        
        stack.addArrangedSubview(buttonRepost)
        stack.spacing = 1
        stack.addArrangedSubview(labelRepost)
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
            
            self.buttonRepost.layer.add(animation, forKey: nil)
        }
        
        if selectedButton == false {
            buttonRepost.setImage(UIImage(systemName: "arrowshape.turn.up.forward.fill"), for: .normal)
            buttonRepost.tintColor = .red
            countRepost += 2
            labelRepost.text = "\(countRepost)"
            labelRepost.textColor = .red
            selectedButton = true
            UIView.transition(with: labelRepost, duration: 0.35, options: .transitionFlipFromBottom, animations: { self.buttonRepost.setImage(UIImage(systemName: "arrowshape.turn.up.forward.fill"), for: .normal) })
            animation()
        }else{
            buttonRepost.setImage(UIImage(systemName: "arrowshape.turn.up.forward"), for: .normal)
            buttonRepost.tintColor = .gray
            countRepost -= 1
            labelRepost.text = "\(countRepost)"
            labelRepost.textColor = .gray
            selectedButton = false
            UIView.transition(with: labelRepost, duration: 0.35, options: .transitionFlipFromBottom, animations: { self.buttonRepost.setImage(UIImage(systemName: "arrowshape.turn.up.forward"), for: .normal) })
            animation()
        }
   }
}

