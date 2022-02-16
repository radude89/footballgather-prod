//
//  PlayerListViewModel+UIModel.swift
//  PlayerListViewModel+UIModel
//
//  Created by Radu Dan on 05.09.2021.
//

import SwiftUI
import CoreModels
import PlayerListAssets

extension PlayersListViewModel {
    
    func accessibilityID(for player: Player, isEditing: Bool) -> AccessibilityID {
        rowAccessibility(for: player, isEditing: isEditing).id
    }
    
    func accessibilityLabel(for player: Player, isEditing: Bool) -> Text {
        rowAccessibility(for: player, isEditing: isEditing).label
    }
    
    private func rowAccessibility(
        for player: Player,
        isEditing: Bool
    ) -> PlayersListRowAccessibility {
        if isEditing {
            return editingRowAccessibility(player)
        }
        
        return .unselected(player)
    }
    
    private func editingRowAccessibility(_ player: Player) -> PlayersListRowAccessibility {
        if hasSelected(player) {
            return .selectedEditing(player)
        }
        
        return .unselectedEditing(player)
    }
    
}
