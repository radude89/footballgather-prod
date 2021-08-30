//
//  PlayerListView.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 24.05.2021.
//

import SwiftUI
import CoreModels

// MARK: - PlayerListView

struct PlayerListView: View {
    let players: [Player]
    
    var body: some View {
        List(players) { player in
            Text("\(player.name)")
        }
        .listStyle(PlainListStyle())
    }
}

// MARK: - Preview

struct PlayerListView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerListView(players: Player.demoPlayers)
            .previewLayout(.sizeThatFits)
    }
}
