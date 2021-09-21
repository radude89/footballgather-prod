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
    
    var saveIsDisabled: Bool {
        selectedPlayer.name.isEmpty
    }
    
}
