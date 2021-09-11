//
//  PlayerDetailsSection.swift
//  PlayerDetailsSection
//
//  Created by Radu Dan on 11.09.2021.
//

import SwiftUI
import Localizable

struct PlayerDetailsSection: View {
    
    let viewModel: PlayerDetailsSectionViewModel
    
    var body: some View {
        Section(
            content: {
                TextField(
                    LocalizedString.playerNameField,
                    text: viewModel.$playerName
                )
                    .disableAutocorrection(true)
            },
            header: {
                Text(LocalizedString.sectionDetailsHeader)
            },
            footer: {
                Text(LocalizedString.sectionDetailsFooter)
            }
        )
    }
    
}

struct PlayerDetailsSection_Previews: PreviewProvider {
    static var previews: some View {
        PlayerDetailsSection(viewModel: .init(playerName: .constant("John")))
    }
}
