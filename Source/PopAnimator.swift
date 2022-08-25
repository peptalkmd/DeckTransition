//
//  PopAnimator.swift
//  DeckTransition
//
//  Created by Ankish Jain on 08/11/18.
//  Copyright © 2018 Harshil Shah. All rights reserved.
//

import Foundation
class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 0.5
    var presenting = true
    var originFrame = CGRect.zero
    
    var dismissCompletion: (()->Void)?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        let herbView : UIView
        if presenting {
            let toView = transitionContext.view(forKey: .to)!
            containerView.addSubview(toView)
            containerView.bringSubviewToFront(toView)
            
            herbView = toView
            
        } else {
            herbView = transitionContext.view(forKey: .from)!
        }
        
        let initialFrame = presenting ? originFrame : herbView.frame
        let finalFrame = presenting ? herbView.frame : originFrame
        
        let xScaleFactor = presenting ?
            initialFrame.width / finalFrame.width :
            finalFrame.width / initialFrame.width
        
        let yScaleFactor = presenting ?
            initialFrame.height / finalFrame.height :
            finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
        
        if presenting {
            herbView.transform = scaleTransform
            herbView.center = CGPoint(
                x: initialFrame.midX,
                y: initialFrame.midY)
            herbView.clipsToBounds = true
        }
        
        /*UIView.animate(withDuration: duration, delay:0.0,
         usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0,
         animations: {
         herbView.transform = self.presenting ? CGAffineTransform.identity : scaleTransform
         herbView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
         }, completion: { _ in
         if !self.presenting {
         self.dismissCompletion?()
         }
         transitionContext.completeTransition(true)
         })*/
        
        UIView.animate(withDuration: duration, animations: {
            herbView.transform = self.presenting ? CGAffineTransform.identity : scaleTransform
            herbView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
        }, completion: { _ in
            if !self.presenting {
                self.dismissCompletion?()
            }
            transitionContext.completeTransition(true)
        })        
    }
}
