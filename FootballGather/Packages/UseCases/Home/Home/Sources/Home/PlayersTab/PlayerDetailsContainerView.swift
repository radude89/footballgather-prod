//
//  PlayerDetailsContainerView.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 07.02.2022.
//

import SwiftUI
import CoreModels
import FoundationTools
import PlayerDetails

struct PlayerDetailsContainerView: View {
    
    private let storage: FoundationTools.AppStorage
    private let player: Player
    private let showListView: Binding<Bool>
    
    init(
        storage: FoundationTools.AppStorage,
        player: Player,
        showListView: Binding<Bool>
    ) {
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
