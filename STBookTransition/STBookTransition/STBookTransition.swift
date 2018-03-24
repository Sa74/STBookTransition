//
//  STBookTransition.swift
//  STBookTransition
//
//  Created by Sasi M on 10/03/18.
//  Copyright © 2018 Sasi Moorthy. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import UIKit

/*
 Book transition style options enum
 */
public enum BookTransitionStyle : Int {
    case None = 0, RightFold, RightUnfold, LeftFold, LeftUnfold
}

/*
 Cube transition delegate to handle animation completion
 */
@objc protocol BookTransitionDelegate: class {
    @objc optional func animationDidFinishWithView(displayView: UIView)
}


class STBookTransition: UIViewController {

    var transform: CATransform3D? = CATransform3DIdentity
    var topSleeve: CALayer?
    var middleSleeve: CALayer?
    var topShadow: CALayer?
    var middleShadow: CALayer?
    var firstJointLayer: CALayer?
    var secondJointLayer: CALayer?
    var perspectiveLayer: CALayer?
    
    public var delegate: BookTransitionDelegate?
    
    public func animateView(_ displayView:UIView, style:BookTransitionStyle, duration:Float) {
        
        let width = displayView.frame.size.width
        let height = displayView.frame.size.height
        self.view.backgroundColor = displayView.backgroundColor
        
        /*
         Get view port as UIImage
         */
        UIGraphicsBeginImageContext(displayView.bounds.size);
        displayView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let viewImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext();
        
        /*
         Split view port image vertically into to two equal part...
         */
        let size = CGSize.init(width: viewImage.size.width/2, height: viewImage.size.height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        viewImage.draw(at: CGPoint.zero, blendMode: CGBlendMode.normal, alpha: 1.0)
        let leftImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext();
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        viewImage.draw(at: CGPoint.init(x: -size.width, y: 0), blendMode: CGBlendMode.normal, alpha: 1.0)
        let rightImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext();
        
        /*
         Hide all subviews of view...
         */
        self.hideSubviewsInView(displayView, isHidden: true)
        
        /*
         Create seperate layers on view port for fold and unfold animations...
         */
        perspectiveLayer = CALayer.init()
        perspectiveLayer!.frame = CGRect.init(x: 0, y: 0, width: width/2, height: height)
        displayView.layer.addSublayer(perspectiveLayer!)
        
        
        firstJointLayer = CATransformLayer.init()
        firstJointLayer!.frame = displayView.bounds;
        perspectiveLayer?.addSublayer(firstJointLayer!)
        
        
        topSleeve = CALayer.init()
        topSleeve!.frame = CGRect.init(x: 0, y: 0, width: width/2, height: height)
        
        
        switch style {
        case .RightFold:
            fallthrough
        case .RightUnfold:
            topSleeve!.anchorPoint = CGPoint.init(x: 1, y: 0.5)
            topSleeve!.position = CGPoint.init(x: width, y: height/2)
            topSleeve!.contents = rightImage.cgImage as Any
            break
            
        case .LeftFold:
            fallthrough
        case .LeftUnfold:
            topSleeve!.anchorPoint = CGPoint.init(x: 0, y: 0.5)
            topSleeve!.position = CGPoint.init(x: 0, y: height/2)
            topSleeve!.contents = leftImage.cgImage as Any;
            break;
            
        default:
            break
        }
        
        
        firstJointLayer!.addSublayer(topSleeve!)
        topSleeve!.masksToBounds = true
        
        secondJointLayer = CATransformLayer.init();
        secondJointLayer!.frame = CGRect.init(x: 0, y: 0, width: width, height: height)
        
        switch style {
        case .RightFold:
            fallthrough
        case .RightUnfold:
            secondJointLayer!.anchorPoint = CGPoint.init(x: 0.5, y: 0.5)
            break
            
        case .LeftFold:
            fallthrough
        case .LeftUnfold:
            secondJointLayer!.anchorPoint = CGPoint.init(x: 0, y: 0.5)
            break
            
        default:
            break
        }
        
        secondJointLayer!.position = CGPoint.init(x: width/2, y: height/2)
        firstJointLayer!.addSublayer(secondJointLayer!)
        
        middleSleeve = CALayer.init()
        middleSleeve!.frame = CGRect.init(x: 0, y: 0, width: width/2, height: height)
        
        switch style {
        case .RightFold:
            fallthrough
        case .RightUnfold:
            middleSleeve!.anchorPoint = CGPoint.init(x: 1, y: 0.5)
            middleSleeve!.contents = leftImage.cgImage as Any;
            middleSleeve!.position = CGPoint.init(x: width/2, y: height/2)
            
            firstJointLayer!.anchorPoint = CGPoint.init(x: 1, y: 0.5)
            firstJointLayer!.position = CGPoint.init(x: width, y: height/2)
            break
            
        case .LeftFold:
            fallthrough
        case .LeftUnfold:
            middleSleeve!.anchorPoint = CGPoint.init(x: 0, y: 0.5)
            middleSleeve!.contents = rightImage.cgImage as Any;
            middleSleeve!.position = CGPoint.init(x: 0, y: height/2)
            
            firstJointLayer!.anchorPoint = CGPoint.init(x: 0, y: 0.5)
            firstJointLayer!.position = CGPoint.init(x: 0, y: height/2)
            break
            
        default:
            break
        }
        
        secondJointLayer!.addSublayer(middleSleeve!)
        middleSleeve!.masksToBounds = true
        
        topShadow = CALayer.init()
        topSleeve!.addSublayer(topShadow!)
        topShadow!.frame = topSleeve!.bounds
        topShadow!.backgroundColor = UIColor.black.cgColor
        topShadow!.opacity = 0;
        
        middleShadow = CALayer.init()
        middleSleeve!.addSublayer(middleShadow!)
        middleShadow!.frame = middleSleeve!.bounds
        middleShadow!.backgroundColor = UIColor.black.cgColor
        middleShadow!.opacity = 0;
        
        transform!.m34 = 1.0/(-700.0);
        perspectiveLayer!.sublayerTransform = transform!
        
        displayView.backgroundColor = UIColor.clear
        
        var animation: CABasicAnimation = CABasicAnimation.init(keyPath: "transform.rotation.y")
        animation.duration = CFTimeInterval(duration)
        animation.autoreverses = false
        animation.repeatCount = 0
        
        switch style {
        case .RightFold:
            animation.fromValue = NSNumber.init(value: 0)
            animation.toValue = NSNumber.init(value: -Double.pi/2)
            break
            
        case .LeftFold:
            animation.fromValue = NSNumber.init(value: 0)
            animation.toValue = NSNumber.init(value: Double.pi/2)
            break
            
        case .RightUnfold:
            animation.fromValue = NSNumber.init(value: -Double.pi/2)
            animation.toValue = NSNumber.init(value: 0)
            break
            
        case .LeftUnfold:
            animation.fromValue = NSNumber.init(value: Double.pi/2)
            animation.toValue = NSNumber.init(value: 0)
            break
            
        default:
            break
        }
        
        firstJointLayer!.add(animation, forKey: nil)
        
        animation = CABasicAnimation.init(keyPath: "transform.rotation.y")
        animation.duration = CFTimeInterval(duration)
        animation.autoreverses = false
        animation.repeatCount = 0
        
        switch style {
        case .RightFold:
            animation.fromValue = NSNumber.init(value: 0)
            animation.toValue = NSNumber.init(value: Double.pi)
            break
            
        case .LeftFold:
            animation.fromValue = NSNumber.init(value: 0)
            animation.toValue = NSNumber.init(value: -Double.pi)
            break
            
        case .RightUnfold:
            animation.fromValue = NSNumber.init(value: Double.pi)
            animation.toValue = NSNumber.init(value: 0)
            break
            
        case .LeftUnfold:
            animation.fromValue = NSNumber.init(value: -Double.pi)
            animation.toValue = NSNumber.init(value: 0)
            break
            
        default:
            break
        }
        
        secondJointLayer!.add(animation, forKey: nil)
        
        animation = CABasicAnimation.init(keyPath: "opacity")
        animation.duration = CFTimeInterval(duration)
        animation.autoreverses = false
        animation.repeatCount = 0
        
        switch style {
        case .RightFold:
            fallthrough
        case .LeftFold:
            animation.fromValue = NSNumber.init(value: 0)
            animation.toValue = NSNumber.init(value: 0.5)
            break
            
        case .RightUnfold:
            fallthrough
        case .LeftUnfold:
            animation.fromValue = NSNumber.init(value: 0.5)
            animation.toValue = NSNumber.init(value: 0)
            break;
            
        default:
            break
        }
        
        topShadow!.add(animation, forKey: nil)
        middleShadow!.add(animation, forKey: nil)
        
        switch style {
        case .RightFold:
            fallthrough
        case .LeftFold:
            UIView.animate(withDuration: TimeInterval(duration), animations: {
                displayView.alpha = 0
            })
            
        default:
            break
        }
        
        self.perform(#selector(removeAllSubLayers), with: displayView, afterDelay: TimeInterval(duration))
    }
    
    func hideSubviewsInView(_ displayView:UIView, isHidden:Bool) {
        for subView in displayView.subviews {
            subView.isHidden = isHidden
        }
        if (isHidden == false) {
            displayView.backgroundColor = self.view.backgroundColor
        }
    }
    
    @objc func removeAllSubLayers(_ displayView: UIView) {
        
        delegate?.animationDidFinishWithView?(displayView: displayView)
        
        firstJointLayer?.removeFromSuperlayer()
        topSleeve?.removeFromSuperlayer()
        middleSleeve?.removeFromSuperlayer()
        topShadow?.removeFromSuperlayer()
        middleShadow?.removeFromSuperlayer()
        secondJointLayer?.removeFromSuperlayer()
        perspectiveLayer?.removeFromSuperlayer()
        
        firstJointLayer = nil;
        topShadow = nil;
        topSleeve = nil;
        middleShadow = nil;
        middleSleeve = nil;
        secondJointLayer = nil;
        perspectiveLayer = nil;
        
        self.hideSubviewsInView(displayView, isHidden: false)
    }

}
