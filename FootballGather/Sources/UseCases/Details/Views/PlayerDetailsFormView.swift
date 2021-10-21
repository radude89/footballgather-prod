//
//  PlayerDetailsFormView.swift
//  PlayerDetailsFormView
//
//  Created by Radu Dan on 11.09.2021.
//

import SwiftUI
import CoreModels

struct PlayerDetailsFormView: View {
    
    let viewModel: PlayerDetailsFormViewModel
    
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

// MARK: - Preview

struct PlayerDetailsFormView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerDetailsFormView(
            viewModel: .init(
                selectedPlayer: .constant(Player.demoPlayers[0]),
                isAddingPlayer: true
            )
        )
    }
}
