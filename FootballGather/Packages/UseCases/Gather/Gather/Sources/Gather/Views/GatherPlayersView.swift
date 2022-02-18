//
//  GatherPlayersView.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 29.11.2021.
//

import SwiftUI
import Localizable
import CoreModels

struct GatherPlayersView: View {
    
    let viewModel: GatherPlayersViewModel
    
    var body: some View {
        List {
            section(for: .teamA)
            section(for: .teamB)
        }
        .listStyle(.grouped)
        .accessibilityID(.gatherPlayersList)
    }
    
    private func section(for team: Team) -> some View {
        Section(
            header: Text(viewModel.sectionName(for: team))
        ) {
            ForEach(viewModel.players(in: team)) { player in
                Text(player.name)
            }
        }
    }
    
}

// MARK: - Preview

struct GatherPlayersView_Previews: PreviewProvider {
    static var previews: some View {
        GatherPlayersView(
            viewModel: .init(
                playersTeams: [
                    .teamA: [.demoPlayers[0], .demoPlayers[2]],
                    .teamB: [.demoPlayers[1]]
                ]
            )
        )
    }
}
