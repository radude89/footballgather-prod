//
//  PositionPickerView.swift
//  PositionPickerView
//
//  Created by Radu Dan on 11.09.2021.
//

import SwiftUI
import PlayerDetailsAssets
import CoreModels

struct PositionPickerView: View {
    
    private let viewModel: PositionPickerViewModel
    
    init(viewModel: PositionPickerViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Picker(
            LocalizedString.position,
            selection: viewModel.$position
        ) {
            ForEach(viewModel.allPositions, id: \.self) { position in
                Text(PositionPickerViewModel.positionRowDescription(position))
                    .tag(position as Player.Position?)
            }
        }
        .pickerStyle(.automatic)
    }
    
}
