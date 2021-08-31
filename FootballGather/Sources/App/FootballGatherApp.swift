//
//  FootballGatherApp.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 25.03.2021.
//

import SwiftUI

struct FootballGatherApp: App {
    
    @StateObject private var storage = AppStorage()
    
    var body: some Scene {
        WindowGroup {
            PlayersView()
                .environmentObject(storage)
        }
    }
}
