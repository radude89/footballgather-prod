//
//  PlayerListView.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 24.05.2021.
//

import SwiftUI
import CoreModels
import Localizable

// MARK: - PlayerListView

struct PlayerListView: View {
    let players: [Player]
    
    @Binding var selectedRows: Set<UUID>
    @Environment(\.editMode) var editMode
    
    var body: some View {
        List(players, selection: $selectedRows) { player in
            Text("\(player.name)")
                .accessibilityLabel(
                    rowAccessibility(for: player).label
                )
                .accessibilityID(rowAccessibility(for: player).id)
        }
        .listStyle(PlainListStyle())
    }
    
    private func rowAccessibility(for player: Player) -> RowAccessibility {
        if isEditing {
            return editingRowAccessibility(for: player)
        }
        
        return unselectedRowAccessibility(for: player)
    }
    
    private var isEditing: Bool {
        editMode?.wrappedValue == .active
    }
    
    private func editingRowAccessibility(for player: Player) -> RowAccessibility {
        if hasSelected(player) {
            return selectedEditingRowAccessibility(for: player)
        }
        
        return unselectedEditingRowAccessibility(for: player)
    }
    
    private func hasSelected(_ player: Player) -> Bool {
        selectedRows.contains(player.id)
    }
    
    private func selectedEditingRowAccessibility(
        for player: Player
    ) -> RowAccessibility {
        RowAccessibility(
            label: Text(
                String(format: LocalizedText.selectedPlayer, "\(player.name)")
            ),
            id: .selectedRow
        )
    }
    
    private func unselectedEditingRowAccessibility(
        for player: Player
    ) -> RowAccessibility {
        RowAccessibility(
            label: Text(
                String(format: LocalizedText.tapToSelectPlayer, "\(player.name)")
            ),
            id: .unselectedRow
        )
    }
    
    private func unselectedRowAccessibility(
        for player: Player
    ) -> RowAccessibility {
        RowAccessibility(
            label: Text("\(player.name)"),
            id: .unselectedRow
        )
    }
}

// MARK: - RowAccessibility

private struct RowAccessibility {
    let label: Text
    let id: AccessibilityID
}

// MARK: - Preview

struct PlayerListView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerListView(
            players: Player.demoPlayers,
            selectedRows: .constant(.init())
        )
            .previewLayout(.sizeThatFits)
    }
}
