//
//  PlayersViewModel.swift
//  PlayersViewModel
//
//  Created by Radu Dan on 02.09.2021.
//

import SwiftUI
import Localizable
import CoreModels

// MARK: - PlayersViewModel

final class PlayersViewModel: ObservableObject {
    
    @Published var isEditing = false
    @Published var selectedRows = Set<UUID>()
    
    private(set) var storage: AppStorage

    init(storage: AppStorage) {
        self.storage = storage
    }
    
}

// MARK: - Player interaction
    
extension PlayersViewModel {
    var hasPlayers: Bool {
        storage.storedPlayers.isEmpty == false
    }
    
    var storedPlayers: [Player] {
        storage.storedPlayers
    }
    
    func toggleEditing() {
        isEditing.toggle()
    }
}
