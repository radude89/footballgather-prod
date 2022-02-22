//
//  NameDetailsSection.swift
//  NameDetailsSection
//
//  Created by Radu Dan on 11.09.2021.
//

import SwiftUI
import PlayerDetailsAssets

struct NameDetailsSection: View {
    
    let viewModel: NameDetailsSectionViewModel
    
    var body: some View {
        Section(
            content: {
                TextField(
                    LocalizedString.playerNameField,
                    text: viewModel.$playerName
                )
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.words)
                    .submitLabel(.done)
                    .accessibilityID(AccessibilityID.enterNameTextfield)
            },
            header: {
                Text(LocalizedString.sectionPlayerDetailsHeader)
            },
            footer: { footerViewContent }
        )
    }
    
    private var footerViewContent: some View {
        viewModel.isAddingPlayer ? Text(LocalizedString.sectionPlayerDetailsFooter) : nil
    }
}

struct NameDetailsSection_Previews: PreviewProvider {
    static var previews: some View {
        NameDetailsSection(
            viewModel: .init(playerName: .constant("John"), isAddingPlayer: true)
        )
    }
}
