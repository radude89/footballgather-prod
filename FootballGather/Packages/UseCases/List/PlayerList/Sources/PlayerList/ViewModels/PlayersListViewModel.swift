//
//  PlayersListViewModel.swift
//  PlayersListViewModel
//
//  Created by Radu Dan on 05.09.2021.
//

import SwiftUI
import CoreModels
import FoundationTools

final class PlayersListViewModel: ObservableObject {
    
    @Binding var selectedRows: Set<UUID>
    @Binding var showListView: Bool
    
    @Published private(set) var players: [Player]
    private(set) var storage: PlayerStorageHandler
    
    init(
        storage: PlayerStorageHandler = AppStorage(),
        selectedRows: Binding<Set<UUID>>,
        showListView: Binding<Bool> = .constant(false)
    ) {
        self.storage = storage
        players = storage.storedPlayers
        _selectedRows = selectedRows
        _showListView = showListView
    }
    
    func hasSelected(_ player: Player) -> Bool {
        selectedRows.contains(player.id)
    }
    
    func delete(_ player: Player) {
        storage.deletePlayer(player)
        reloadPlayers()
        updateBindingToShowListView()
    }
    
    private func reloadPlayers() {
        players = storage.storedPlayers
    }
    
    private func updateBindingToShowListView() {
        showListView = !players.isEmpty
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
