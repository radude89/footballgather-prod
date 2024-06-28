//
//  FootballGatherApp.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 25.03.2021.
//

import SwiftUI
import Home
import FoundationTools

struct FootballGatherApp: App {
    
    @StateObject private var storage = FoundationTools.AppStorage()

    var body: some Scene {
        WindowGroup {
            MainView(storage: storage) {
                updateAnimationsIfRunningUITests()
            }
        }
    }
    
    private func updateAnimationsIfRunningUITests() {
        if CommandLineHandler().isRunningUITests {
            UIView.setAnimationsEnabled(false)
            (UIApplication.shared.connectedScenes.first! as! UIWindowScene).keyWindow?.layer.speed = 100
        }
    }
    
}
