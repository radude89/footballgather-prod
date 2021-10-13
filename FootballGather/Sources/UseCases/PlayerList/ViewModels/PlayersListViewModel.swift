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
    
    @Binding var selectedRows: Set<UUID>
    let players: [Player]
    
    private(set) var storage: AppStorage
    
    init(
        storage: AppStorage,
        players: [Player],
        selectedRows: Binding<Set<UUID>>
    ) {
        self.storage = storage
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
