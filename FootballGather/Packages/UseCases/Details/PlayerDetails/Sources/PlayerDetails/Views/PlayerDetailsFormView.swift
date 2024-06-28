//
//  PlayerDetailsFormView.swift
//  PlayerDetailsFormView
//
//  Created by Radu Dan on 11.09.2021.
//

import SwiftUI
import CoreModels

struct PlayerDetailsFormView: View {
    
    private let viewModel: PlayerDetailsFormViewModel
    
    init(viewModel: PlayerDetailsFormViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Form {
            NameDetailsSection(
                viewModel: .init(
                    playerName: viewModel.$selectedPlayer.name,
                    isAddingPlayer: viewModel.isAddingPlayer
                )
            )
            
            SkillAndPositionSection(
                viewModel: .init(
                    skill: viewModel.$selectedPlayer.skill,
                    position: viewModel.$selectedPlayer.position,
                    isAddingPlayer: viewModel.isAddingPlayer
                )
            )
        }
    }
    
}
