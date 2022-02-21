//
//  MainView.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 17.01.2022.
//

import SwiftUI
import FoundationTools

public struct MainView: View {
    
    @EnvironmentObject var storage: FoundationTools.AppStorage
    
    public init(completion: () -> Void) {
        completion()
    }
    
    public var body: some View {
        MainTabView(tabProviders: [
            PlayersTabView(storage: storage).provider,
            HistoryTabView(storage: storage).provider
        ])
    }
    
}

// MARK: - Previews

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView {}
            .environmentObject(AppStorage())
    }
}
