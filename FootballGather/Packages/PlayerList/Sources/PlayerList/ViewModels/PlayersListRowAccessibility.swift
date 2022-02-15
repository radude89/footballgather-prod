//
//  PlayersListRowAccessibility.swift
//  PlayersListRowAccessibility
//
//  Created by Radu Dan on 02.09.2021.
//

import SwiftUI
import Localizable
import CoreModels

struct PlayersListRowAccessibility {
    let label: Text
    let id: AccessibilityID
}

extension PlayersListRowAccessibility: Equatable {}

extension PlayersListRowAccessibility {
    static func selectedEditing(_ player: Player) -> PlayersListRowAccessibility {
        PlayersListRowAccessibility(
            label: Text(
                String(format: LocalizedString.selectedPlayer, "\(player.name)")
            ),
            id: .selectedRow
        )
    }
    
    static func unselectedEditing(_ player: Player) -> PlayersListRowAccessibility {
        PlayersListRowAccessibility(
            label: Text(
                String(format: LocalizedString.tapSelectPlayer, "\(player.name)")
            ),
            id: .unselectedRow
        )
    }
    
    static func unselected(_ player: Player) -> PlayersListRowAccessibility {
        PlayersListRowAccessibility(
            label: Text(String(player.name)),
            id: .unselectedRow
        )
    }
}
