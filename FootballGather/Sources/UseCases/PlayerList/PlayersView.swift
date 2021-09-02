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
    
    @EnvironmentObject var storage: AppStorage
    
    @State private var isEditing = false
    @State private var selectedRows = Set<UUID>()
    
    private var hasPlayers: Bool {
        storage.storedPlayers.isEmpty
    }
    
    var body: some View {
        NavigationView {
            Group {
                if hasPlayers {
                    EmptyPlayersView()
                } else {
                    PlayerListView(players: storage.storedPlayers, selectedRows: $selectedRows)
                }
            }
            .navigationTitle(formattedNavigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: hasPlayers ? nil : leadingBarButton,
                trailing: trailingBarButton
            )
            .environment(\.editMode, .constant(isEditing ? .active : .inactive))
        }
        .accessibilityID(mainViewAccessibilityID)
    }
    
    private var formattedNavigationTitle: String {
        if !isEditing && numberOfSelectedPlayers > 0 {
            return String(format: LocalizedText.selectedCount, numberOfSelectedPlayers)
        }
        return LocalizedText.players
    }
    
    private var numberOfSelectedPlayers: Int {
        selectedRows.count
    }
    
    private var leadingBarButton: some View {
        Button(
            action: toggleEditing
        ) {
            Text(isEditing ? LocalizedText.done : LocalizedText.edit)
        }
        .accessibilityID(isEditing ? .doneButton : .editButton)
        .accessibility(
            hint: Text(
                isEditing ? LocalizedText.doneHint : LocalizedText.editHint
            )
        )
    }
    
    private func toggleEditing() {
        isEditing.toggle()
        
        if !isEditing {
            print(selectedRows)
        }
    }
    
    private var trailingBarButton: some View {
        Button(action: addPlayers) {
            Image(systemName: "plus")
                .accessibility(removeTraits: .isImage)
        }
        .accessibilityID(.addButton)
        .accessibility(hint: Text(LocalizedText.addPlayersHint))
        .accessibility(label: Text(LocalizedText.addPlayerLabel))
    }
    
    private func addPlayers() {
        storage.updatePlayers(Player.demoPlayers)
    }
    
    private var mainViewAccessibilityID: Localizable.AccessibilityID {
        hasPlayers ? .emptyView : .playerList
    }
}

// MARK: - Preview

struct PlayersView_Previews: PreviewProvider {
    static var previews: some View {
        PlayersView()
            .environmentObject(AppStorage())
    }
}
