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
        VStack {
            GatherPlayersView(
                viewModel: .init(playersTeams: viewModel.playersTeams)
            )
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle(LocalizedString.gatherInProgress)
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
