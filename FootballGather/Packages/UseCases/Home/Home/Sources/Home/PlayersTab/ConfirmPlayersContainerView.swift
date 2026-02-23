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

struct ConfirmPlayersContainerView: View {

    private let storage: FoundationTools.AppStorage
    private let players: [Player]
    private let gatherEnded: Binding<Bool>

    @State private var gatherPlayersTeams: [Team: [Player]]?

    init(
        storage: FoundationTools.AppStorage,
        players: [Player],
        gatherEnded: Binding<Bool>
    ) {
        self.storage = storage
        self.players = players
        self.gatherEnded = gatherEnded
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
                    gatherEnded: gatherEnded,
                    viewModel: .init(playersTeams: playersTeams)
                )
            }
        }
    }

}
