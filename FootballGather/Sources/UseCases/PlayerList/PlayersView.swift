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
    private var players: [Player] = [
//        Player(name: "John"),
//        Player(name: "Jane"),
//        Player(name: "Arthur")
    ]
    
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

// MARK: - PlayerListView

struct PlayerListView: View {
    let players: [Player]
    
    var body: some View {
        List {
            ForEach(players) { player in
                Text("\(player.name)")
            }
        }
    }
}

// MARK: - Empty View

struct EmptyPlayersView: View {
    var body: some View {
        Text(LocalizedText.noPlayers)
            .multilineTextAlignment(.center)
            .padding()
    }
}

// MARK: - Preview

struct PlayerListView_Previews: PreviewProvider {
    static var previews: some View {
        PlayersView()
    }
}
