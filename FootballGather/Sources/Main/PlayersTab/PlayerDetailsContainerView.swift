//
//  PlayerDetailsContainerView.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 07.02.2022.
//

import SwiftUI
import CoreModels

struct PlayerDetailsContainerView: View {
    
    private let storage: AppStorage
    private let player: Player
    private let showListView: Binding<Bool>
    
    init(storage: AppStorage, player: Player, showListView: Binding<Bool>) {
        self.storage = storage
        self.player = player
        self.showListView = showListView
    }
    
    var body: some View {
        PlayerDetailsView(
            viewModel: .init(
                storage: storage,
                state: .viewingDetails,
                player: player,
                showListView: showListView
            )
        )
    }
    
}

// MARK: - Previews

struct PlayerDetailsContainerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerDetailsContainerView(
            storage: .init(),
            player: .demoPlayers.randomElement()!,
            showListView: .constant(true)
        )
    }
}
