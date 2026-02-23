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
import UITools
#if DEBUG
import FoundationMocks
#endif

public struct GatherView: View {
    
    private let viewModel: GatherViewModel
    private let storage: FoundationTools.AppStorage
    
    @Binding private var gatherEnded: Bool
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var showingSetTimerView = false
    @State private var showingBackConfirmation = false
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
        ScrollView {
            VStack(spacing: 24) {
                ScoreView(viewModel: scoreViewModel)
                
                TimerView(viewModel: .init(timeSettings: timeSettings)) {
                    showingSetTimerView = true
                }
                
                GatherPlayersView(
                    viewModel: .init(playersTeams: viewModel.playersTeams)
                )
                .padding(.horizontal)
            }
            .padding(.top, 16)
            .padding(.bottom, 24)
        }
        .scrollContentBackground(.hidden)
        .safeAreaInset(edge: .bottom) {
            GatherEndView(completion: onCompleteGather)
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .sheet(isPresented: $showingSetTimerView) {
            setTimerView
        }
        .environment(timeSettings)
        .navigationBarBackButtonHidden(true)
        .navigationTitle(LocalizedString.gatherInProgress)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    showingBackConfirmation = true
                } label: {
                    Image(systemName: "chevron.left")
                }
            }
        }
        .confirmationAlert(
            isPresented: $showingBackConfirmation,
            title: LocalizedString.backGatherConfirmation,
            message: LocalizedString.backGatherMessage,
            cancelTitle: LocalizedString.no,
            confirmActionTitle: LocalizedString.yes
        ) {
            dismiss()
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

#if DEBUG
#Preview {
    @Previewable @State var gatherEnded = false
    
    return NavigationStack {
        GatherView(
            storage: Mocks.storage,
            gatherEnded: $gatherEnded,
            viewModel: .init(
                playersTeams: [
                    .teamA: [
                        Player(name: "John"),
                        Player(name: "Jane"),
                        Player(name: "Arthur")
                    ],
                    .teamB: [
                        Player(name: "Michael"),
                        Player(name: "Sarah"),
                        Player(name: "David")
                    ]
                ]
            )
        )
    }
}
#endif

