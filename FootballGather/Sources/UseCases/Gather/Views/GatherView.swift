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
    
    @State private var showingSetTimerView = false
    
    var body: some View {
        VStack {
            ScoreView(viewModel: .init())
            
            TimerView(viewModel: .init()) {
                showingSetTimerView = true
            }
            
            GatherPlayersView(
                viewModel: .init(playersTeams: viewModel.playersTeams)
            )
            
            GatherEndView()
        }
        .sheet(isPresented: $showingSetTimerView) {
            SetTimerView(viewModel: .init())
        }
        .padding(.bottom)
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
