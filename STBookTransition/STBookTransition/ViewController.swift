//
//  ViewController.swift
//  STBookTransition
//
//  Created by Sasi M on 10/03/18.
//  Copyright © 2018 Sasi Moorthy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, BookTransitionDelegate {

    @IBOutlet weak var displayView: UIView!
    var bookTransition : STBookTransition?
    var transitionStyle : BookTransitionStyle = .None
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bookTransition = STBookTransition()
    }

    
    @IBAction func rightFoldTapped(_ sender: Any) {
        transitionStyle = .RightFold
        self.bookTransition?.animateView(displayView, style: transitionStyle, delay: 0.5, delegate: self)
    }
    
    @IBAction func rightUnfoldTapped(_ sender: Any) {
        self.displayView.alpha = 1.0
        self.displayView.isHidden = false
        transitionStyle = .RightUnfold
        self.bookTransition?.animateView(displayView, style: transitionStyle, delay: 0.5, delegate: self)
    }
    
    @IBAction func leftFoldTapped(_ sender: Any) {
        transitionStyle = .LeftFold
        self.bookTransition?.animateView(displayView, style: transitionStyle, delay: 0.5, delegate: self)
    }
    
    @IBAction func leftUnfoldTapped(_ sender: Any) {
        self.displayView.alpha = 1.0
        self.displayView.isHidden = false
        transitionStyle = .LeftUnfold
        self.bookTransition?.animateView(displayView, style: transitionStyle, delay: 0.5, delegate: self)
    }
    
    func animationDidFinishWithView(displayView: UIView) {
        switch transitionStyle {
        case .RightFold:
            fallthrough
        case .LeftFold:
            self.displayView.isHidden = true
            break

        case .RightUnfold:
            fallthrough
        case .LeftUnfold:
            self.displayView.isHidden = false
            break

        default:
            break
        }
    }
    
}

