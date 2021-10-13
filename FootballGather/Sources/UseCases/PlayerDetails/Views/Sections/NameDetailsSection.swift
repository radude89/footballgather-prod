//
//  NameDetailsSection.swift
//  NameDetailsSection
//
//  Created by Radu Dan on 11.09.2021.
//

import SwiftUI
import Localizable

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
                    .accessibilityID(.enterNameTextfield)
            },
            header: {
                Text(LocalizedString.sectionDetailsHeader)
            },
            footer: { footerViewContent }
        )
    }
    
    private var footerViewContent: some View {
        viewModel.isAddingPlayer ? Text(LocalizedString.sectionDetailsFooter) : nil
    }
}

struct NameDetailsSection_Previews: PreviewProvider {
    static var previews: some View {
        NameDetailsSection(
            viewModel: .init(playerName: .constant("John"), isAddingPlayer: true)
        )
    }
}
