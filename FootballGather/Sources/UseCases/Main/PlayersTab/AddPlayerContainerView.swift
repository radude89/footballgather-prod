//
//  AddPlayerContainerView.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 07.02.2022.
//

import SwiftUI

struct AddPlayerContainerView: View {
    
    private let storage: AppStorage
    
    var showListView: Binding<Bool>
    
    init(storage: AppStorage, showListView: Binding<Bool>) {
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

// MARK: - Previews

struct AddPlayerContainerView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlayerContainerView(
            storage: .init(),
            showListView: .constant(true)
        )
    }
}
