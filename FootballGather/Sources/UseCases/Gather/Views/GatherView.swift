//
//  GatherView.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 23.11.2021.
//

import SwiftUI
import Localizable
import CoreModels

struct GatherView: View {
    
    let viewModel: GatherViewModel
    
    var body: some View {
        List {
            Section(header: Text("TEAM A")) {
                ForEach(viewModel.players(in: .teamA)) { player in
                    Text(player.name)
                }
            }
            
            Section(header: Text("TEAM B")) {
                ForEach(viewModel.players(in: .teamB)) { player in
                    Text(player.name)
                }
            }
        }
        .listStyle(.plain)
        .accessibilityID(.gatherView)
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Gather in progress")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview

struct GatherView_Previews: PreviewProvider {
    static var previews: some View {
        GatherView(
            viewModel: .init(
                playersTeams: [
                    .teamA: [.demoPlayers[0], .demoPlayers[2]],
                    .teamB: [.demoPlayers[1]]
                ]
            )
        )
    }
}
