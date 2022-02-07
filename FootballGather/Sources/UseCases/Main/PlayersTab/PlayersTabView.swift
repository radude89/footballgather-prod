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
        PlayersView(
            viewModel: .init(storage: storage),
            addViewProvider: { showListView in
                addPlayerContainerView(showListBinding: showListView)
            },
            detailsViewProvider: { showListView, player in
                playerDetailsContainerView(player: player, showListBinding: showListView)
            }
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
        player: Player,
        showListBinding: Binding<Bool>
    ) -> PlayerDetailsContainerView {
        .init(
            storage: storage,
            player: player,
            showListView: showListBinding
        )
    }
    
}
