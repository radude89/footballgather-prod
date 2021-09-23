//
//  AddPlayerViewModel.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 21.09.2021.
//

import SwiftUI
import CoreModels

final class AddPlayerViewModel: ObservableObject {
    
    @Published var selectedPlayer = Player(name: "")
    
    private let storage: AppStorage
    
    init(storage: AppStorage) {
        self.storage = storage
    }
    
    var saveIsDisabled: Bool {
        selectedPlayer.name.isEmpty
    }
    
    var hasEnteredDetails: Bool {
        selectedPlayer.name.isEmpty == false ||
        selectedPlayer.skill != nil ||
        selectedPlayer.position != nil
    }
    
    func savePlayer() {
        guard selectedPlayer.name.isEmpty == false else {
            return
        }
        
        storage.addPlayer(selectedPlayer)
    }
    
}
