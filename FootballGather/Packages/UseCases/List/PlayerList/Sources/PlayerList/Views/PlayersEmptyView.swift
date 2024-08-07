//
//  PlayersEmptyView.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 24.05.2021.
//

import SwiftUI
import PlayerListAssets

struct PlayersEmptyView: View {
    var body: some View {
        Text(LocalizedString.noPlayers)
            .multilineTextAlignment(.center)
            .padding()
    }
}
