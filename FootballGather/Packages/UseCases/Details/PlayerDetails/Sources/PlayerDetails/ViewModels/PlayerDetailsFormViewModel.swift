//
//  PlayerDetailsFormViewModel.swift
//  PlayerDetailsFormViewModel
//
//  Created by Radu Dan on 11.09.2021.
//

import SwiftUI
import CoreModels

@MainActor
struct PlayerDetailsFormViewModel {
    @Binding var selectedPlayer: Player
    let isAddingPlayer: Bool
}
