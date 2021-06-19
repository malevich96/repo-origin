//
//  DotLoadView.swift
//  VK1_App
//
//  Created by Анатолий Левин on 03.06.2021.
//

import UIKit

class DotLoadView: UIView {
  
  var dotSize: CGFloat = 18
  var correction: CGFloat = 2.2
  
  var backView: UIView {
    let view = UIView()
    view.frame = bounds
    view.layer.backgroundColor = .none
    view.layer.opacity = 0.2
    return view
  }
  
  var dotView: UIView {
    let view = UIView()
    view.frame = CGRect(x: 0, y: 0, width: dotSize, height: dotSize)
    view.layer.cornerRadius = view.frame.width / 2
    view.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    view.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    view.layer.shadowOpacity = 1
    view.layer.shadowRadius = 5
    view.layer.shadowOffset = .zero
    view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
    return view
  }

  override init(frame rect: CGRect) {
    super.init(frame: .zero)
    setupView()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    backgroundColor = UIColor.clear
    setupView()
  }
  
  private func setupView() {
    let dotView0 = dotView
    let dotView1 = dotView
    let dotView2 = dotView
    
    dotView0.frame = CGRect(x: bounds.maxX / correction - dotSize * 2, y: bounds.maxY / correction, width: dotSize, height: dotSize)
    dotView1.frame = CGRect(x: bounds.maxX / correction, y: bounds.maxY / correction, width: dotSize, height: dotSize)
    dotView2.frame = CGRect(x: bounds.maxX / correction + dotSize * 2, y: bounds.maxY / correction, width: dotSize, height: dotSize)
    addSubview(backView)
    addSubview(dotView0)
    addSubview(dotView1)
    addSubview(dotView2)
    
    dotAnimate(view: dotView0, beginTime: 0.0)
    dotAnimate(view: dotView1, beginTime: 0.2)
    dotAnimate(view: dotView2, beginTime: 0.4)
  }
  
  private func dotAnimate(view: UIView, beginTime: Double) {
    let animation = CABasicAnimation(keyPath: "opacity")
    animation.beginTime = CACurrentMediaTime() + beginTime
    animation.fromValue = 1
    animation.toValue = 0
    animation.duration = 1
    animation.repeatCount = .infinity
    view.layer.add(animation, forKey: nil)
  }
}
