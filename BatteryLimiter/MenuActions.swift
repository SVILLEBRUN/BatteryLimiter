//
//  MenuActions.swift
//  BatteryLimiter
//
//  Created by Sébastien VILLEBRUN on 19/10/2025.
//

import Cocoa

class MenuActions: NSObject {
    static let shared = MenuActions()

    @objc func enableBatteryLimit() {
        BatteryService.shared.enableBatteryLimit(80)
    }

    @objc func disableBatteryLimit() {
        BatteryService.shared.disableBatteryLimit()
    }

    @objc func quitApp() {
        NSLog("[BatteryLimiter] Quit clicked")
        NSApplication.shared.terminate(nil)
    }
}
