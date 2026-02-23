//
//  ConfirmPlayersContainerView.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 08.02.2022.
//

import SwiftUI
import CoreModels
import TeamSelection
import Gather
import FoundationTools
import PlayerListAssets

struct ConfirmPlayersContainerView: View {

    private let storage: FoundationTools.AppStorage
    private let players: [Player]

    @Binding private var isPresented: Bool

    @State private var gatherPlayersTeams: [Team: [Player]]?
    @State private var gatherEnded = false

    init(
        storage: FoundationTools.AppStorage,
        players: [Player],
        isPresented: Binding<Bool>
    ) {
        self.storage = storage
        self.players = players
        _isPresented = isPresented
    }

    var body: some View {
        ConfirmPlayersView(
            players: players,
            gatherCoordinator: GatherCoordinator(
                gatherPlayersTeams: $gatherPlayersTeams
            )
        )
        .navigationDestination(
            isPresented: Binding(
                get: { gatherPlayersTeams != nil },
                set: { if !$0 { gatherPlayersTeams = nil } }
            )
        ) {
            if let playersTeams = gatherPlayersTeams {
                GatherView(
                    storage: storage,
                    gatherEnded: $gatherEnded,
                    viewModel: .init(playersTeams: playersTeams)
                )
            }
        }
        .alert(
            LocalizedString.gatherCompleteTitle,
            isPresented: $gatherEnded,
            actions: {
                Button(LocalizedString.ok, role: .cancel) {
                    isPresented = false
                }
            }, message: {
                Text(LocalizedString.gatherCompleteMessage)
            }
        )
    }

}
