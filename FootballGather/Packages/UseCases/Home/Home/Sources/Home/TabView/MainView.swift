//
//  MainView.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 17.01.2022.
//

import SwiftUI
import FoundationTools

public struct MainView: View {
    
    @ObservedObject private var storage: FoundationTools.AppStorage
    
    public init(
        storage: FoundationTools.AppStorage,
        completion: () -> Void
    ) {
        self.storage = storage
        completion()
    }
    
    public var body: some View {
        MainTabView(tabProviders: [
            PlayersTabView(storage: storage).provider,
            HistoryTabView(storage: storage).provider
        ])
    }
    
}
