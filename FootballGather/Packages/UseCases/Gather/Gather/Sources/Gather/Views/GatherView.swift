//
//  GatherView.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 23.11.2021.
//

import SwiftUI
import GatherAssets
import CoreModels
import FoundationTools

public struct GatherView: View {
    
    @Binding var gatherEnded: Bool
    @EnvironmentObject var storage: FoundationTools.AppStorage
    let viewModel: GatherViewModel
    
    @State private var showingSetTimerView = false
    @State private var timeSettings = TimeSettings()
    @StateObject private var scoreViewModel = ScoreViewModel()
    
    public init(gatherEnded: Binding<Bool>, viewModel: GatherViewModel) {
        _gatherEnded = gatherEnded
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack {
            ScrollView {
                gatherViewContent
            }
            GatherEndView(completion: onCompleteGather)
        }
        .sheet(isPresented: $showingSetTimerView) {
            setTimerView
        }
        .environment(timeSettings)
        .padding(.bottom)
        .navigationBarBackButtonHidden(true)
        .navigationTitle(LocalizedString.gatherInProgress)
    }
    
    private var gatherViewContent: some View {
        VStack {
            ScoreView(viewModel: scoreViewModel)
            
            TimerView(viewModel: .init(timeSettings: timeSettings)) {
                showingSetTimerView = true
            }
            
            GatherPlayersView(
                viewModel: .init(playersTeams: viewModel.playersTeams)
            )
                .scaledToFill()
        }
    }
    
    private var setTimerView: some View {
        let time = viewModel.formattedTime(from: timeSettings)
        
        return SetTimerView(
            selectedMinutes: time.minutes,
            selectedSeconds: time.seconds
        )
    }
    
    private func onCompleteGather() {
        gatherEnded = true
        viewModel.storeGather(
            score: scoreViewModel.formattedScore,
            storage: storage
        )
    }
    
}

// MARK: - Preview

struct GatherView_Previews: PreviewProvider {
    static var previews: some View {
        GatherView(
            gatherEnded: .constant(false),
            viewModel: .init(
                playersTeams: [
                    .teamA: [.demoPlayers[0], .demoPlayers[2]],
                    .teamB: [.demoPlayers[1]]
                ]
            )
        )
    }
}
