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
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.hasPlayers {
                    EmptyPlayersView()
                } else {
                    PlayerListView(
                        players: viewModel.storedPlayers,
                        selectedRows: $viewModel.selectedRows
                    )
                }
            }
            .navigationTitle(formattedNavigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: viewModel.hasPlayers ? nil : leadingBarButton,
                trailing: trailingBarButton
            )
            .environment(\.editMode, .constant(viewModel.isEditing ? .active : .inactive))
        }
        .accessibilityID(mainViewAccessibilityID)
    }
    
    private var formattedNavigationTitle: String {
        if !viewModel.isEditing && numberOfSelectedPlayers > 0 {
            return String(format: LocalizedText.selectedCount, numberOfSelectedPlayers)
        }
        
        return LocalizedText.players
    }
    
    private var numberOfSelectedPlayers: Int {
        viewModel.selectedRows.count
    }
    
    private var leadingBarButton: some View {
        Button(action: toggleEditing) {
            Text(viewModel.isEditing ? LocalizedText.done : LocalizedText.edit)
        }
        .accessibilityID(viewModel.isEditing ? .doneButton : .editButton)
        .accessibility(
            hint: Text(
                viewModel.isEditing ? LocalizedText.doneHint : LocalizedText.editHint
            )
        )
    }
    
    private func toggleEditing() {
        viewModel.isEditing.toggle()
        
        if !viewModel.isEditing {
            print(viewModel.selectedRows)
        }
    }
    
    private var trailingBarButton: some View {
        Button(action: updatePlayers) {
            Image(systemName: "plus")
                .accessibility(removeTraits: .isImage)
        }
        .accessibilityID(.addButton)
        .accessibility(hint: Text(LocalizedText.addPlayersHint))
        .accessibility(label: Text(LocalizedText.addPlayerLabel))
    }
    
    private func updatePlayers() {
        // TODO: Add the real implementation
        viewModel.updatePlayers(Player.demoPlayers)
    }
    
    private var mainViewAccessibilityID: Localizable.AccessibilityID {
        viewModel.hasPlayers ? .emptyView : .playerList
    }
}

// MARK: - Preview

struct PlayersView_Previews: PreviewProvider {
    static var previews: some View {
        PlayersView(viewModel: .init(storage: AppStorage()))
    }
}
