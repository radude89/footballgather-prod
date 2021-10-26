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
    
    private(set) var players: [Player]
    private(set) var storage: AppStorage
    
    init(
        storage: AppStorage,
        selectedRows: Binding<Set<UUID>>
    ) {
        self.storage = storage
        players = storage.storedPlayers
        _selectedRows = selectedRows
    }
    
    func hasSelected(_ player: Player) -> Bool {
        selectedRows.contains(player.id)
    }
    
    static func formattedRowTitle(for player: Player) -> String {
        player.name
    }
    
    var shouldConfirmPlayers: Bool {
        selectedRows.count >= minAllowedPlayersToStartMatch
    }
    
    private let minAllowedPlayersToStartMatch = 2
    
    var selectedPlayers: [Player] {
        players.filter { selectedRows.contains($0.id) }
    }
    
}
