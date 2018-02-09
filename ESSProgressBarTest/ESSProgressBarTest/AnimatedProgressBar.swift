//
//  AnimatedProgressBar.swift
//  ESSProgressBarTest
//
//  Created by Omar Zúñiga Lagunas on 09/02/18.
//  Copyright © 2018 omarzl.com All rights reserved.
//

import Cocoa

typealias progressBarAnimationCompletion = () -> ()

class AnimatedProgressBar : NSProgressIndicator {

    var animation : ProgressBarAnimation?
    
    func animate(toDouble val:Double, duration: Double = 0.5, animationCurve: NSAnimation.Curve = .linear, completionBlock: progressBarAnimationCompletion?) {
        
        if let animation = animation {
            let oldValue = animation.nextValue
            animation.stop()
            doubleValue = oldValue
            self.animation = nil
        }
        
        animation = ProgressBarAnimation(progressIndicator: self, newValue: val, duration: duration, animationCurve: animationCurve, completionBlock: { [weak self] in
            self?.animation = nil
            completionBlock?()
        })
        animation?.start()
    }
}

class ProgressBarAnimation : NSAnimation {
    
    weak var indicator : NSProgressIndicator?
    var initialValue = 0.0
    var nextValue = 0.0
    var completionBlock : progressBarAnimationCompletion?
    
    init(progressIndicator:NSProgressIndicator, newValue: Double, duration: Double, animationCurve: NSAnimation.Curve, completionBlock: progressBarAnimationCompletion?) {
        super.init(duration: duration, animationCurve: animationCurve)
        indicator = progressIndicator
        initialValue = progressIndicator.doubleValue
        nextValue = newValue
        self.completionBlock = completionBlock
        animationBlockingMode = .nonblocking
    }
    
    override var currentProgress: NSAnimation.Progress {
        didSet {
            let delta = nextValue - initialValue
            indicator?.doubleValue = initialValue + (delta * Double(currentValue))
            if currentProgress == 1.0 {
                completionBlock?()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
