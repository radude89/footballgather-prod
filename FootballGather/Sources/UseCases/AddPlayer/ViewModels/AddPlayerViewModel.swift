//
//  AddPlayerViewModel.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 21.09.2021.
//

import SwiftUI
import CoreModels
import FoundationTools

final class AddPlayerViewModel: ObservableObject {
    
    @Published var selectedPlayer = Player(name: "")
    
    private let storage: AppStorage
    
    init(storage: AppStorage) {
        self.storage = storage
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
