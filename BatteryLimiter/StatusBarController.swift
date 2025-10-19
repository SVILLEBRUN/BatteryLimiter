//
//  StatusBarController.swift
//  BatteryLimiter
//
//  Created by Sébastien VILLEBRUN on 19/10/2025.
//

import Cocoa
import IOKit.ps

class StatusBarController: NSObject, NSMenuDelegate {
    private var statusItem: NSStatusItem
    private let menu: NSMenu

    override init() {
        // Create status bar icon
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        menu = NSMenu()
        super.init()
        menu.delegate = self
        setupMenu()
        setupIcon()
        NSLog("StatusBarController: initialized status bar icon and menu")
    }

    private func setupIcon() {
        if let button = statusItem.button {
            if let img = NSImage(named: "StatusIcon") {
                img.isTemplate = true
                button.image = img
            } else {
                button.title = "BL"
            }
            button.toolTip = "BatteryLimiter"
        }
    }

    private func setupMenu() {
        let actions = MenuActions.shared

        // Battery info placeholders (multi-line)
        let batteryStatusItem = NSMenuItem(title: "--", action: nil, keyEquivalent: "")
        batteryStatusItem.isEnabled = false
        batteryStatusItem.identifier = NSUserInterfaceItemIdentifier("batteryStatusItem")
        menu.addItem(batteryStatusItem)

        menu.addItem(NSMenuItem.separator())

        let enableItem = NSMenuItem(title: "Enable battery limit 80%", action: #selector(actions.enableBatteryLimit), keyEquivalent: "")
        enableItem.target = actions
        menu.addItem(enableItem)

        let disableItem = NSMenuItem(title: "Disable battery limit", action: #selector(actions.disableBatteryLimit), keyEquivalent: "")
        disableItem.target = actions
        menu.addItem(disableItem)

        menu.addItem(NSMenuItem.separator())

        let quitItem = NSMenuItem(title: "Quit", action: #selector(actions.quitApp), keyEquivalent: "q")
        quitItem.target = actions
        menu.addItem(quitItem)

        statusItem.menu = menu
    }
    
    func menuWillOpen(_ menu: NSMenu) {
        updateBatteryInfo()
    }
    
    private func updateBatteryInfo() {
        let batteryStatusItem = menu.items.first { $0.identifier?.rawValue == "batteryStatusItem" }
        
        if let snapshot = IOPSCopyPowerSourcesInfo()?.takeRetainedValue(),
            let sources = IOPSCopyPowerSourcesList(snapshot)?.takeRetainedValue() as? [CFTypeRef],
            let ps = sources.first,
            let description = IOPSGetPowerSourceDescription(snapshot, ps)?.takeUnretainedValue() as? [String: Any] {

            let current = description[kIOPSCurrentCapacityKey as String] as? Int ?? 0
            let max = description[kIOPSMaxCapacityKey as String] as? Int ?? 1
            let percentage = Int(Double(current) / Double(max) * 100)
            let isCharging = description[kIOPSIsChargingKey as String] as? Bool ?? false

            // Determine if Mac is plugged in (AC power)
            let powerSourceType = description[kIOPSPowerSourceStateKey as String] as? String ?? "Unknown"
            let isPluggedIn = (powerSourceType == kIOPSACPowerValue)

            batteryStatusItem?.title = "Battery: \(percentage)%, \(isPluggedIn ? "Plugged in \(isCharging ? "and charging" : "not charging")" : "On battery")"
        }
    }
}

