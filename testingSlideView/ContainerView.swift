//
//  containerView.swift
//  testingSlideView
//
//  Created by Cage Johnson on 1/25/17.
//  Copyright © 2017 desk. All rights reserved.
//

import Foundation
import UIKit

class ContainerView: UIView {
    
    var panGestureRecognizer: UIPanGestureRecognizer!
    var touchEnabledSideView: UIView!
    var allPad: UIView!
    var oldTranslation: CGPoint!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        allPad = Bundle.main.loadNibNamed("AllPad", owner: nil, options: nil)?.first as? UIView
        print(allPad.frame)
        self.addSubview(allPad)
        allPad.frame.origin.x = self.frame.width
        touchEnabledSideView = UIView(frame: CGRect(x: self.frame.width - 40, y: 0, width: 40, height: self.frame.height))
        self.addSubview(touchEnabledSideView)
        touchEnabledSideView.backgroundColor = UIColor.blue
        touchEnabledSideView.layer.opacity = 0.5
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(ContainerView.handlePan(sender:)))
        
        touchEnabledSideView.addGestureRecognizer(panGestureRecognizer)
        
        self.backgroundColor = UIColor.gray
        
    }
    
    func handlePan(sender: UIPanGestureRecognizer){
        if (sender.state == .began){ oldTranslation = sender.translation(in: touchEnabledSideView); return}
        
        
        
        if (sender.state == .changed){
        let dx = sender.translation(in: touchEnabledSideView).x - oldTranslation.x
        oldTranslation = sender.translation(in: touchEnabledSideView)
        
            
        touchEnabledSideView.frame = touchEnabledSideView.frame.offsetBy(dx: dx, dy: 0)
        allPad.frame = allPad.frame.offsetBy(dx: dx, dy: 0)
            
            
        }
        
        
        
        
        if(sender.state == .ended){
            oldTranslation = nil
            
            animateAllPad()
            
        }
    }
    
    
    
    func animateAllPad() {
        CATransaction.begin()
        CATransaction.setAnimationDuration(1)
        /*CATransaction.setCompletionBlock({
            self.allPad.isUserInteractionEnabled = true
        })
 */
        
        //position animation
        let positionAnimation: CABasicAnimation = CABasicAnimation(keyPath: "position")
        let originPosition: CGPoint = allPad.center
        let finalPosition: CGPoint
        
        
        if(allPad.frame.origin.x > (self.frame.width/2)){
            finalPosition = CGPoint(x:self.frame.width + allPad.frame.width/2,y:allPad.frame.height/2)
            CATransaction.setCompletionBlock({
                self.allPad.isUserInteractionEnabled = true
           // self.allPad.center = CGPoint(x:self.frame.width + self.allPad.frame.width/2,y: self.allPad.frame.height/2)              //  self.allPad.layer.position = finalPosition
            })
        } else {finalPosition = CGPoint(x:self.frame.width/2,y:self.frame.height/2)

            CATransaction.setCompletionBlock({
                self.allPad.isUserInteractionEnabled = true
             //   self.allPad.center = CGPoint(x:self.frame.width/2,y:self.frame.height/2)
                //self.allPad.layer.position = finalPosition
            })
        }
        allPad.center = finalPosition
        positionAnimation.duration = 1
        positionAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        positionAnimation.fromValue = NSValue(cgPoint: originPosition)
        positionAnimation.toValue = NSValue(cgPoint: finalPosition)
        positionAnimation.beginTime = CACurrentMediaTime()
        positionAnimation.fillMode = kCAFillModeForwards
        positionAnimation.isRemovedOnCompletion = true
        allPad.layer.add(positionAnimation, forKey: "positionAnimation")
        
        
        CATransaction.commit()
    }

    
    
    
    
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
