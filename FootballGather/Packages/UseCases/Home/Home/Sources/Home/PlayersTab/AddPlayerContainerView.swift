//
//  AddPlayerContainerView.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 07.02.2022.
//

import SwiftUI
import FoundationTools
import PlayerDetails

struct AddPlayerContainerView: View {
    
    private let storage: FoundationTools.AppStorage
    private let showListView: Binding<Bool>
    
    init(
        storage: FoundationTools.AppStorage,
        showListView: Binding<Bool>
    ) {
        self.storage = storage
        self.showListView = showListView
    }
    
    var body: some View {
        PlayerDetailsView(
            viewModel: .init(
                storage: storage,
                state: .addingPlayers,
                showListView: showListView
            )
        )
    }
    
}
