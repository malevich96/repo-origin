//
//  BrowsingPhotosViewController.swift
//  VK1_App
//
//  Created by Анатолий Левин on 04.04.2021.
//

import UIKit

class BrowsingPhotosViewController: UIViewController {
    
    var photos: [UIImage] = []
    var selectedIndex: Int = 0
    
    @IBOutlet weak var browsingPhotosView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        browsingPhotosView.image = photos[selectedIndex]
        browsingPhotosView.backgroundColor = view.backgroundColor
        
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeftAction))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeRightAction))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
    }
    
    @objc
    func swipeLeftAction() {
        guard photos.count > selectedIndex + 1 else { return }
        let nextImage = photos[selectedIndex + 1]
        let newTemporaryImageView = UIImageView()
        newTemporaryImageView.backgroundColor = view.backgroundColor
        newTemporaryImageView.contentMode = .scaleAspectFill
        newTemporaryImageView.image = nextImage
        newTemporaryImageView.frame = browsingPhotosView.frame
        newTemporaryImageView.frame.origin.x += browsingPhotosView.frame.width
        view.addSubview(newTemporaryImageView)
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3) {
                self.browsingPhotosView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.7) {
                newTemporaryImageView.frame.origin.x = 0
    }
        } completion: { _ in
            self.selectedIndex += 1
            self.browsingPhotosView.image = nextImage
            self.browsingPhotosView.transform = .identity
            newTemporaryImageView.removeFromSuperview()
        }
    }
    
    @objc
    func swipeRightAction() {
        guard selectedIndex > 0 else { return }
        let nextImage = photos[selectedIndex - 1]
        let newTemporaryImageView = UIImageView()
        newTemporaryImageView.backgroundColor = view.backgroundColor
        newTemporaryImageView.contentMode = .scaleAspectFill
        newTemporaryImageView.image = nextImage
        newTemporaryImageView.frame = browsingPhotosView.frame
        newTemporaryImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        view.addSubview(newTemporaryImageView)
        view.sendSubviewToBack(newTemporaryImageView)
        
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: []) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.7) {
                self.browsingPhotosView.transform = CGAffineTransform(translationX: self.view.bounds.width, y: 0)
        }
            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.3) {
                newTemporaryImageView.transform = .identity
    }
        } completion: { _ in
            self.selectedIndex -= 1
            self.browsingPhotosView.image = nextImage
            self.browsingPhotosView.transform = .identity
            newTemporaryImageView.removeFromSuperview()
        }
     }
}
