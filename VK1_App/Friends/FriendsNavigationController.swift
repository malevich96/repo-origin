//
//  FriendsNavigationController.swift
//  VK1_App
//
//  Created by Анатолий Левин on 03.06.2021.
//

import Foundation
 
import UIKit

class FriendsNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    let interactiveTrasition = CustomInteractiveTransition()
}

extension FriendsNavigationController: UINavigationControllerDelegate {
   func navigationController(
    _ navigationController: UINavigationController, interactionControllerFor animationController:
    UIViewControllerAnimatedTransitioning)
    -> UIViewControllerInteractiveTransitioning? {
        return interactiveTrasition.hasStarted ? interactiveTrasition : nil
    }
    
    func navigationController(
    _ navigationController: UINavigationController,
    animationControllerFor operation:
    UINavigationController.Operation,
    from fromVC: UIViewController,
    to toVC: UIViewController
   ) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .push {
            self.interactiveTrasition.viewController = toVC
            return CustomPushAnimatorX()
        } else if operation == .pop {
            if navigationController.viewControllers.first != toVC {
                self.interactiveTrasition.viewController = toVC
            }
            return CustomPopAnimatorX()
        }
        return nil
    }
}


final class CustomPushAnimatorX: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let sourse = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        
        destination.view.frame = sourse.view.frame
        let translate = CGAffineTransform(translationX: 150, y: sourse.view.frame.width + 200)
        let rotate = CGAffineTransform(rotationAngle: -1.55)
        destination.view.transform = translate.concatenating(rotate)
        
        UIView.animateKeyframes (
            withDuration: self.transitionDuration(using: transitionContext),
            delay: 0,
            options: .calculationModePaced,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0,
                                   relativeDuration: 0.75,
                                   animations: {
                                    let translate = CGAffineTransform(translationX: -100, y: 300)
                                    let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
                                    sourse.view.transform = translate.concatenating(scale)
                })
                UIView.addKeyframe(withRelativeStartTime: 0.2,
                                   relativeDuration: 0.4,
                                   animations: {
                                    let translate = CGAffineTransform(translationX: 0, y: 0)
                                    let rotate = CGAffineTransform(rotationAngle: 0)
                                    destination.view.transform = translate.concatenating(rotate)
                                    
                })
                UIView.addKeyframe(withRelativeStartTime: 0.6,
                                   relativeDuration: 0.4,
                                   animations: {
                                    destination.view.transform = .identity
                })
            }) { finished in
            if finished && !transitionContext.transitionWasCancelled {
                sourse.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }
}


final class CustomPopAnimatorX: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let sourse = transitionContext.viewController(forKey: .from) else { return }
        guard let destination = transitionContext.viewController(forKey: .to) else { return }
        
        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.sendSubviewToBack(destination.view)
        
        destination.view.frame = sourse.view.frame
        
        let translate = CGAffineTransform(translationX: -100, y: 300)
        let scale = CGAffineTransform(scaleX: 0.8, y: 0.8)
        destination.view.transform = translate.concatenating(scale)
        
        UIView.animateKeyframes (
            withDuration: self.transitionDuration(using: transitionContext),
            delay: 0,
            options: .calculationModePaced,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0,
                                   relativeDuration: 0.4,
                                   animations: {
                                    let translate = CGAffineTransform(translationX: 0, y: 0)
                                    let rotate = CGAffineTransform(rotationAngle: 0)
                                    sourse.view.transform = translate.concatenating(rotate)
                })
                UIView.addKeyframe(withRelativeStartTime: 0.4,
                                   relativeDuration: 0.4,
                                   animations: {
                                    let translate = CGAffineTransform(translationX: 150, y: sourse.view.frame.width + 200)
                                    let rotate = CGAffineTransform(rotationAngle: -1.55)
                                    sourse.view.transform = translate.concatenating(rotate)
                                    
                })
                UIView.addKeyframe(withRelativeStartTime: 0.25,
                                   relativeDuration: 0.75,
                                   animations: {
                                    destination.view.transform = .identity
                })
                
            }) { finished in
            if finished && !transitionContext.transitionWasCancelled {
                sourse.removeFromParent()
            } else if transitionContext.transitionWasCancelled {
                destination.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }
    }
}

class CustomInteractiveTransition: UIPercentDrivenInteractiveTransition {
    var viewController: UIViewController? {
        didSet {
            let recognizer = UIScreenEdgePanGestureRecognizer(target: self,
                                                              
                                                              action: #selector(handleScreenEngeGesture(_:)))
            recognizer.edges = [.left]
            viewController?.view.addGestureRecognizer(recognizer)
        }
    }
    
    var hasStarted: Bool = false
    var shouldFinish: Bool = false
    @objc func handleScreenEngeGesture(_ recognizer: UIScreenEdgePanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            self.hasStarted = true
            self.viewController?.navigationController?.popViewController(animated: true)
        case .changed:
            let translation = recognizer.translation(in: recognizer.view)
            let relativeTranslation = translation.x /
                ( (recognizer.view?.bounds.width ?? 1) / 10 )
            let progress = max(0, min(1, relativeTranslation))
            self.shouldFinish = progress > 0.15
            self.update(progress)
        case .ended:
            self.hasStarted = false
            self.shouldFinish ? self.finish() : self.cancel()
        case .cancelled:
            self.hasStarted = false
            self.cancel()
        default: return
        }
    }
}

