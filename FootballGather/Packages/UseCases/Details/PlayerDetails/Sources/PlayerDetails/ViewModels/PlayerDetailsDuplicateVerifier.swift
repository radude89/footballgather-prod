//
//  PlayerDetailsDuplicateVerifier.swift
//  UITests
//
//  Created by Radu Dan on 14.10.2021.
//

import CoreModels
import FoundationTools

@MainActor
struct PlayerDetailsDuplicateVerifier {
    private let storage: PlayerStorageHandler
    
    init(storage: PlayerStorageHandler) {
        self.storage = storage
    }
    
    func sameDetailsEntered(for player: Player) -> Bool {
        guard let storedPlayer = storage.storedPlayers.first(
            where: { $0.id == player.id }
        ) else {
            return false
        }
        
        return storedPlayer == player
    }
}
