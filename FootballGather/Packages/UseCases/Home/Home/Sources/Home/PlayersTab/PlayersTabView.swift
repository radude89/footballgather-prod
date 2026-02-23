//
//  PlayersTabView.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 07.02.2022.
//

import SwiftUI
import CoreModels
import FoundationTools
import PlayerList
import HomeAssets

@MainActor
struct PlayersTabView {
    
    private let storage: FoundationTools.AppStorage
    
    init(storage: FoundationTools.AppStorage) {
        self.storage = storage
    }
    
    var provider: MainTabViewProvider {
        .init(
            icon: Images.players.icon,
            title: LocalizedString.players,
            view: playersView
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
        isPresented: Binding<Bool>
    ) -> ConfirmPlayersContainerView {
        .init(
            storage: storage,
            players: players,
            isPresented: isPresented
        )
    }
    
}
