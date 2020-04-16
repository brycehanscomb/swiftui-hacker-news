//
//  AppDelegate.swift
//  Hacker News
//
//  Created by Bryce Hanscomb on 14/4/20.
//  Copyright © 2020 Bryce Hanscomb. All rights reserved.
//

import Cocoa
import SwiftUI
import AppKit

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the SwiftUI view that provides the window contents.
        let contentView = ContentView()

        // Create the window and set the content view. 
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
            styleMask: [.titled, .miniaturizable, .resizable],
            backing: .buffered, defer: false)
        window.center()
        
        window.setFrameAutosaveName("Main Window")
        window.contentView = NSHostingView(rootView: contentView)
        
        window.title = "Hacker News"
        
//        window.titleVisibility = .hidden
        
        self.createTitleBar(window: window)
        
        window.makeKeyAndOrderFront(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func createTitleBar(window: NSWindow) {
        let titlebarAccessoryView = TitlebarAccessory().edgesIgnoringSafeArea(.top)
        let accessoryHostingView = NSHostingView(rootView:titlebarAccessoryView)
        let titlebarAccessory = NSTitlebarAccessoryViewController()
        
        titlebarAccessory.view = accessoryHostingView
        titlebarAccessory.layoutAttribute = .bottom
        accessoryHostingView.frame.size = accessoryHostingView.intrinsicContentSize
        
        // Add the titlebar accessory
        window.addTitlebarAccessoryViewController(titlebarAccessory)
    }


}

