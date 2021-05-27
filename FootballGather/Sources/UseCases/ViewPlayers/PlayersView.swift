//
//  PlayerListView.swift
//  UITests
//
//  Created by Radu Dan on 18.05.2021.
//

import SwiftUI
import Localizable
import CoreModels

// MARK: - PlayersView

struct PlayersView: View {
    
    @EnvironmentObject var storage: AppStorage
    
    private var players: [Player] {
        storage.storedPlayers
    }
    
    var body: some View {
        NavigationView {
            Group {
                if players.isEmpty {
                    EmptyPlayersView()
                } else {
                    PlayerListView(players: players)
                }
            }
            .navigationTitle(LocalizedText.players)
            .navigationBarTitleDisplayMode(.inline)
        }
        .accessibilityID(mainViewAccessibilityID)
    }
    
    private var mainViewAccessibilityID: Localizable.AccessibilityID {
        players.isEmpty ? .emptyView : .playerList
    }
}

// MARK: - Preview

struct PlayersView_Previews: PreviewProvider {
    static var previews: some View {
        PlayersView()
    }
}
