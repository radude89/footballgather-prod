//
//  FootballGatherApp.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 25.03.2021.
//

import SwiftUI
import FoundationTools

struct FootballGatherApp: App {
    
    @StateObject private var storage = AppStorage()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(storage)
        }
    }
    
}
