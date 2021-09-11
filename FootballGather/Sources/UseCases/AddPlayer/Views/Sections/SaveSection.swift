//
//  SaveSection.swift
//  SaveSection
//
//  Created by Radu Dan on 11.09.2021.
//

import SwiftUI
import Localizable

struct SaveSection: View {
    
    let viewModel: SaveSectionViewModel
    let onSave: (() -> Void)
    
    var body: some View {
        Section {
            Button(LocalizedString.save, action: onSave)
                .disabled(viewModel.playerName.isEmpty)
        }
    }
    
}

struct SaveSection_Previews: PreviewProvider {
    static var previews: some View {
        SaveSection(viewModel: .init(playerName: .constant("John")), onSave: {})
    }
}
