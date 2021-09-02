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
    
    private func rowAccessibility(for player: Player) -> PlayerListRowAccessibility {
        if isEditing {
            return editingRowAccessibility(player)
        }
        
        return .unselected(player)
    }
    
    private var isEditing: Bool {
        editMode?.wrappedValue == .active
    }
    
    private func editingRowAccessibility(_ player: Player) -> PlayerListRowAccessibility {
        if hasSelected(player) {
            return .selectedEditing(player)
        }
        
        return .unselectedEditing(player)
    }
    
    private func hasSelected(_ player: Player) -> Bool {
        selectedRows.contains(player.id)
    }
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
