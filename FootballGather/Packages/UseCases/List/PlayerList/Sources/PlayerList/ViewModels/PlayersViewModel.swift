//
//  PlayersViewModel.swift
//  PlayersViewModel
//
//  Created by Radu Dan on 02.09.2021.
//

import SwiftUI
import CoreModels
import FoundationTools

// MARK: - PlayersViewModel

public final class PlayersViewModel: ObservableObject {
    
    @Published var isSelectingPlayers = false
    @Published var selectedRows = Set<UUID>()
    
    private(set) var storage: PlayerStorageHandler

    public init(storage: PlayerStorageHandler = AppStorage()) {
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
