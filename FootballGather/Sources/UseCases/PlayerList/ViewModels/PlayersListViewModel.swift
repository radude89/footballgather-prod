//
//  PlayersListViewModel.swift
//  PlayersListViewModel
//
//  Created by Radu Dan on 05.09.2021.
//

import CoreModels
import Localizable
import SwiftUI

final class PlayersListViewModel {
    
    let players: [Player]
    
    @Binding var selectedRows: Set<UUID>
    
    init(players: [Player], selectedRows: Binding<Set<UUID>>) {
        self.players = players
        _selectedRows = selectedRows
    }
    
    func hasSelected(_ player: Player) -> Bool {
        selectedRows.contains(player.id)
    }
    
    static func formattedRowTitle(for player: Player) -> String {
        player.name
    }
    
}
