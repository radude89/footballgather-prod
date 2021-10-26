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
    
    @Published var isSelectingPlayers = false
    @Published var selectedRows = Set<UUID>()
    
    private(set) var storage: AppStorage

    init(storage: AppStorage) {
        self.storage = storage
    }
    
    func reloadView() {
        objectWillChange.send()
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
    
    func toggleSelection() {
        isSelectingPlayers.toggle()
        clearSelectedRowsIfNeeded()
    }
    
    private func clearSelectedRowsIfNeeded() {
        guard !isSelectingPlayers else {
            return
        }
        
        selectedRows = []
    }
}
