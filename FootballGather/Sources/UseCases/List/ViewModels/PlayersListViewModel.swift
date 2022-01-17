//
//  PlayersListViewModel.swift
//  PlayersListViewModel
//
//  Created by Radu Dan on 05.09.2021.
//

import CoreModels
import Localizable
import SwiftUI

final class PlayersListViewModel: ObservableObject {
    
    @Binding var selectedRows: Set<UUID>
    
    @Published private(set) var players: [Player]
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
    
    func delete(_ player: Player) {
        storage.deletePlayer(player)
        players = storage.storedPlayers
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
