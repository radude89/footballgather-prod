//
//  PlayersListViewModel.swift
//  PlayersListViewModel
//
//  Created by Radu Dan on 05.09.2021.
//

import SwiftUI
import CoreModels
import FoundationTools

@Observable
final class PlayersListViewModel {
    
    @ObservationIgnored
    @Binding var showListView: Bool
    
    private(set) var players: [Player]
    
    @ObservationIgnored
    private(set) var storage: PlayerStorageHandler
    
    init(
        storage: PlayerStorageHandler = AppStorage(),
        showListView: Binding<Bool> = .constant(false)
    ) {
        self.storage = storage
        players = storage.storedPlayers
        _showListView = showListView
    }
    
    func delete(at indexSet: IndexSet) {
        indexSet.forEach { delete(players[$0]) }
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
    
}
