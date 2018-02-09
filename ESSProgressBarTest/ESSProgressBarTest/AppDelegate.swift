//
//  AppDelegate.swift
//  ESSProgressBarTest
//
//  Created by Omar Zúñiga Lagunas on 09/02/18.
//  Copyright © 2018 omarzl.com All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    @IBOutlet weak var indicator: AnimatedProgressBar!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.increaseByTen()
        }
    }
    
    func increaseByTen() {
        indicator.animate(toDouble: indicator.doubleValue+500) { [weak self] in
            if self?.indicator.doubleValue ?? 0 >= 1000 {
                self?.decreaseByTen()
            } else {
                self?.increaseByTen()
            }
        }
    }
    
    func decreaseByTen() {
        indicator.animate(toDouble: indicator.doubleValue-500, duration: 2.0, animationCurve: .linear) { [weak self] in
            if self?.indicator.doubleValue ?? 0 <= 0 {
                self?.increaseByTen()
            } else {
                self?.decreaseByTen()
            }
        }
    }
}

