//
//  BatteryService.swift
//  BatteryLimiter
//
//  Created by Sébastien VILLEBRUN on 19/10/2025.
//

import Foundation

// This service will handle all battery related logic
// Currently placeholder methods; in future can call system APIs

class BatteryService {
    static let shared = BatteryService()

    private init() {
        NSLog("BatteryService initialized")
    }

    func enableBatteryLimit(_ percent: Int) {
        // Placeholder: simulate enabling battery limit
        NSLog("BatteryService: Enable battery limit to \(percent)%")
        print("Simulated enabling battery limit to \(percent)%")
    }

    func disableBatteryLimit() {
        // Placeholder: simulate disabling battery limit
        NSLog("BatteryService: Disable battery limit")
        print("Simulated disabling battery limit")
    }
}
