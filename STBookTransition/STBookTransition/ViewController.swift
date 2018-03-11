//
//  ViewController.swift
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
        self.bookTransition?.animateView(displayView, style: transitionStyle, duration: 0.5, delegate: self)
    }
    
    @IBAction func rightUnfoldTapped(_ sender: Any) {
        self.displayView.alpha = 1.0
        self.displayView.isHidden = false
        transitionStyle = .RightUnfold
        self.bookTransition?.animateView(displayView, style: transitionStyle, duration: 0.5, delegate: self)
    }
    
    @IBAction func leftFoldTapped(_ sender: Any) {
        transitionStyle = .LeftFold
        self.bookTransition?.animateView(displayView, style: transitionStyle, duration: 0.5, delegate: self)
    }
    
    @IBAction func leftUnfoldTapped(_ sender: Any) {
        self.displayView.alpha = 1.0
        self.displayView.isHidden = false
        transitionStyle = .LeftUnfold
        self.bookTransition?.animateView(displayView, style: transitionStyle, duration: 0.5, delegate: self)
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

