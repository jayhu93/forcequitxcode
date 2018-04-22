//
//  MainViewController.swift
//  Jay
//
//  Created by YupinHuPro on 4/20/18.
//  Copyright © 2018 jayyupinhu. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {
    var counter = 0 {
        didSet {
            counterLabel.stringValue = String(describing: "\(counter)")
        }
    }
    @IBOutlet weak var counterLabel: NSTextField!

    
    @IBAction func forceQuit(_ sender: NSButton) {
        let runningApps = NSWorkspace.shared.runningApplications
        if let xApp = runningApps.filter( { ($0.bundleIdentifier != nil) && ($0.bundleIdentifier! == "com.apple.dt.Xcode") }).first {
            counter = counter + 1
            xApp.forceTerminate()
        }
    }
    @IBAction func forceRestart(_ sender: NSButton) {
        let runningApps = NSWorkspace.shared.runningApplications
        if let xApp = runningApps.filter( { ($0.bundleIdentifier != nil) && ($0.bundleIdentifier! == "com.apple.dt.Xcode") }).first {
            counter = counter + 1
            let didTerminate = xApp.forceTerminate()
            if didTerminate {
                NSWorkspace.shared.open(URL(fileURLWithPath: "/Applications/Xcode.app"))
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load")
        counter = 0
        counterLabel.stringValue = "0"
    }
    @IBAction func quit(_ sender: NSButton) {
        NSApplication.shared.terminate(sender)
    }
}

extension MainViewController {
    static func freshController() -> MainViewController {
        let storyboard = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil)
        let identifier = NSStoryboard.SceneIdentifier(rawValue: "MainViewController")
        let viewController = storyboard.instantiateController(withIdentifier: identifier) as! MainViewController
        return viewController
    }
}
