//
//  PlayersTabView.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 07.02.2022.
//

import SwiftUI
import Localizable
import CoreModels

struct PlayersTabView {
    
    private let storage: AppStorage
    
    init(storage: AppStorage) {
        self.storage = storage
    }
    
    var provider: MainTabViewProvider {
        .init(
            icon: "person.3.sequence",
            title: LocalizedString.players,
            view: { AnyView(playersView) }
        )
    }
    
    private var playersView: some View {
        let viewProvider = PlayersViewProvider(
            addView: addPlayerContainerView,
            detailsView: playerDetailsContainerView,
            confirmPlayersView: confirmPlayersContainerView
        )
        
        return PlayersView(
            viewModel: .init(storage: storage),
            viewProvider: viewProvider
        )
    }
    
    private func addPlayerContainerView(
        showListBinding: Binding<Bool>
    ) -> AddPlayerContainerView {
        .init(
            storage: storage,
            showListView: showListBinding
        )
    }
    
    private func playerDetailsContainerView(
        showListBinding: Binding<Bool>,
        player: Player
    ) -> PlayerDetailsContainerView {
        .init(
            storage: storage,
            player: player,
            showListView: showListBinding
        )
    }
    
    private func confirmPlayersContainerView(
        players: [Player],
        gatherEnded: Binding<Bool>
    ) -> ConfirmPlayersContainerView {
        .init(
            players: players,
            gatherEnded: gatherEnded
        )
    }
    
}
