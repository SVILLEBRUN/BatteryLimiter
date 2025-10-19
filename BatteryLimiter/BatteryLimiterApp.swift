//
//  BatteryLimiterApp.swift
//  BatteryLimiter
//
//  Created by Sébastien VILLEBRUN on 19/10/2025.
//

import SwiftUI

@main
struct BatteryLimiterApp: App {
    // We connect our AppDelegate (which will manage the menu bar)
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        // No main window, but we must define an empty Scene to satisfy SwiftUI
        Settings {
            EmptyView()
        }
    }
}
