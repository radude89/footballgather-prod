//
//  PlayerDetailsViewModel.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 21.09.2021.
//

import SwiftUI
import CoreModels
import FoundationTools

final class PlayerDetailsViewModel: ObservableObject {
    
    @Published var selectedPlayer: Player
    
    private let storage: AppStorage
    
    init(storage: AppStorage, player: Player = .init(name: "")) {
        self.storage = storage
        selectedPlayer = player
    }
    
    var hasEnteredDetails: Bool {
        selectedPlayer.name.isEmpty == false ||
        selectedPlayer.skill != nil ||
        selectedPlayer.position != nil
    }
    
    var playerIsValid: Bool {
        NameValidator(name: selectedPlayer.name).isValid
    }
    
    func savePlayer() {
        storage.addPlayer(selectedPlayer)
    }
    
}
