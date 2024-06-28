//
//  PlayersViewModel.swift
//  PlayersViewModel
//
//  Created by Radu Dan on 02.09.2021.
//

import SwiftUI
import CoreModels
import FoundationTools

@Observable
@MainActor
public final class PlayersViewModel {
    
    private(set) var storage: PlayerStorageHandler

    public init(storage: PlayerStorageHandler) {
        self.storage = storage
    }
    
    var hasPlayers: Bool {
        storage.storedPlayers.isEmpty == false
    }
    
    var storedPlayers: [Player] {
        storage.storedPlayers
    }
    
    func reloadView() {
//        objectWillChange.send()
    }
    
}
