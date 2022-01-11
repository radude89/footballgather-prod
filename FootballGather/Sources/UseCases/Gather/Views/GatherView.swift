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
    @StateObject private var timeSettings = TimeSettings()
    
    var body: some View {
        VStack {
            ScoreView(viewModel: .init())
            
            TimerView(viewModel: .init(timeSettings: timeSettings)) {
                showingSetTimerView = true
            }
            
            GatherPlayersView(
                viewModel: .init(playersTeams: viewModel.playersTeams)
            )
            
            GatherEndView()
        }
        .sheet(isPresented: $showingSetTimerView) {
            setTimerView
        }
        .environmentObject(timeSettings)
        .padding(.bottom)
        .navigationBarBackButtonHidden(true)
        .navigationTitle(LocalizedString.gatherInProgress)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var setTimerView: some View {
        let time = viewModel.formattedTime(from: timeSettings)
        
        return SetTimerView(
            selectedMinutes: time.minutes,
            selectedSeconds: time.seconds
        )
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
