//
//  AddPlayerFormView.swift
//  AddPlayerFormView
//
//  Created by Radu Dan on 11.09.2021.
//

import SwiftUI
import CoreModels

struct AddPlayerFormView: View {
    
    let viewModel: AddPlayerFormViewModel
    
    var body: some View {
        Form {
            PlayerDetailsSection(
                viewModel: .init(
                    playerName: viewModel.$selectedPlayer.name
                )
            )
            
            SkillAndPositionSection(
                viewModel: .init(
                    skill: viewModel.$selectedPlayer.skill,
                    position: viewModel.$selectedPlayer.position
                )
            )
        }
    }
    
}

// MARK: - Preview

struct AddPlayerFormView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlayerFormView(
            viewModel: .init(
                selectedPlayer: .constant(Player.demoPlayers[0])
            )
        )
    }
}
