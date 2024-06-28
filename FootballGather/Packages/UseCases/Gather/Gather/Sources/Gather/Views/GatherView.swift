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
    
    private let viewModel: GatherViewModel
    private let storage: FoundationTools.AppStorage
    
    @Binding private var gatherEnded: Bool
    
    @State private var showingSetTimerView = false
    @State private var timeSettings = TimeSettings()
    @State private var scoreViewModel = ScoreViewModel()
    
    public init(
        storage: FoundationTools.AppStorage,
        gatherEnded: Binding<Bool>,
        viewModel: GatherViewModel
    ) {
        self.storage = storage
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
