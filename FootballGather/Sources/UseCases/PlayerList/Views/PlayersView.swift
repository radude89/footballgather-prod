//
//  PlayerListView.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 18.05.2021.
//

import SwiftUI
import Localizable
import CoreModels

// MARK: - PlayersView

struct PlayersView: View {
    
    @ObservedObject var viewModel: PlayersViewModel
    
    @State private var showAddView = false
    
    var body: some View {
        NavigationView {
            mainContent
                .navigationTitle(viewModel.formattedNavigationTitle)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(
                    leading: viewModel.hasPlayers ? leadingBarButton : nil,
                    trailing: trailingBarButton
                )
                .environment(\.editMode, viewModel.editModeBinding)
                .sheet(
                    isPresented: $showAddView,
                    content: AddPlayerView.init
                )
        }
        .accessibilityID(viewModel.mainViewAccessibilityID)
    }
    
    @ViewBuilder
    private var mainContent: some View {
        if !viewModel.hasPlayers {
            PlayersEmptyView()
        } else {
            PlayersListView(
                viewModel: .init(
                    players: viewModel.storedPlayers,
                    selectedRows: $viewModel.selectedRows
                )
            )
        }
    }
    
    private var leadingBarButton: some View {
        Button(action: toggleEditing) {
            Text(viewModel.leadingBarButton.title)
        }
        .accessibilityID(viewModel.leadingBarButton.accessibilityID)
        .accessibilityHint(
            Text(viewModel.leadingBarButton.accessibilityHint)
        )
        .accessibilityLabel(
            Text(viewModel.leadingBarButton.accessibilityLabel)
        )
    }
    
    private func toggleEditing() {
        viewModel.toggleEditing()
        
        if !viewModel.isEditing {
            print(viewModel.selectedRows)
        }
    }
    
    private var trailingBarButton: some View {
        Button(action: { showAddView = true }) {
            Image(systemName: "plus")
                .accessibility(removeTraits: .isImage)
        }
        .accessibilityID(viewModel.trailingBarButton.accessibilityID)
        .accessibilityHint(
            Text(viewModel.trailingBarButton.accessibilityHint)
        )
        .accessibilityLabel(
            Text(viewModel.trailingBarButton.accessibilityLabel)
        )
    }
}

// MARK: - Preview

struct PlayersView_Previews: PreviewProvider {
    static var previews: some View {
        PlayersView(viewModel: .init(storage: AppStorage()))
    }
}
