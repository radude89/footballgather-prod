//
//  PositionPickerViewModel.swift
//  PositionPickerViewModel
//
//  Created by Radu Dan on 11.09.2021.
//

import SwiftUI
import CoreModels

struct PositionPickerViewModel {
    
    @Binding var position: Player.Position?
    
    let allPositions: [Player.Position]
    
    init(
        position: Binding<Player.Position?>,
        allPositions: [Player.Position] = Player.Position.allCases
    ) {
        _position = position
        self.allPositions = allPositions
    }

    static func positionRowDescription(_ position: Player.Position) -> String {
        position.rawValue.capitalized
    }
    
}
