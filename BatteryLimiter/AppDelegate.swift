//
//  AppDelegate.swift
//  BatteryLimiter
//
//  Created by Sébastien VILLEBRUN on 19/10/2025.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarController: StatusBarController?

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Initialize the status bar controller which manages icon and menu
        statusBarController = StatusBarController()
        NSLog("AppDelegate: Application did finish launching")
    }
}
