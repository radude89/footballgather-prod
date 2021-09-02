//
//  PlayerListRowAccessibility.swift
//  PlayerListRowAccessibility
//
//  Created by Radu Dan on 02.09.2021.
//

import SwiftUI
import Localizable
import CoreModels

struct PlayerListRowAccessibility {
    let label: Text
    let id: AccessibilityID
}

extension PlayerListRowAccessibility: Equatable {}

extension PlayerListRowAccessibility {
    static func selectedEditing(_ player: Player) -> PlayerListRowAccessibility {
        PlayerListRowAccessibility(
            label: Text(
                String(format: LocalizedText.selectedPlayer, "\(player.name)")
            ),
            id: .selectedRow
        )
    }
    
    static func unselectedEditing(_ player: Player) -> PlayerListRowAccessibility {
        PlayerListRowAccessibility(
            label: Text(
                String(format: LocalizedText.tapToSelectPlayer, "\(player.name)")
            ),
            id: .unselectedRow
        )
    }
    
    static func unselected(_ player: Player) -> PlayerListRowAccessibility {
        PlayerListRowAccessibility(
            label: Text(String(player.name)),
            id: .unselectedRow
        )
    }
}
