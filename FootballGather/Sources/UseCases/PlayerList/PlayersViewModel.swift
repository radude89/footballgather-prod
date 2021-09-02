//
//  PlayersViewModel.swift
//  PlayersViewModel
//
//  Created by Radu Dan on 02.09.2021.
//

import SwiftUI
import FoundationTools
import CoreModels

final class PlayersViewModel: ObservableObject {
    
    @Published var isEditing = false
    @Published var selectedRows = Set<UUID>()
    
    private let storage: AppStorage
    
    init(storage: AppStorage) {
        self.storage = storage
    }
    
    var hasPlayers: Bool {
        storage.storedPlayers.isEmpty
    }
    
    var storedPlayers: [Player] {
        storage.storedPlayers
    }
    
    func addPlayers() {
        storage.updatePlayers(Player.demoPlayers)
    }
    
    func updatePlayers(_ players: [Player]) {
        storage.updatePlayers(players)
    }
    
}
