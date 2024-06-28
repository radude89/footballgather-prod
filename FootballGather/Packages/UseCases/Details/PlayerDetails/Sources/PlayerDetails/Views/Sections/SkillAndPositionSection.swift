//
//  SkillAndPositionSection.swift
//  SkillAndPositionSection
//
//  Created by Radu Dan on 11.09.2021.
//

import SwiftUI
import PlayerDetailsAssets

struct SkillAndPositionSection: View {
    
    private let viewModel: SkillAndPositionSectionViewModel
    
    init(viewModel: SkillAndPositionSectionViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Section(
            content: {
                SkillPickerView(
                    viewModel: .init(skill: viewModel.$skill)
                )
                PositionPickerView(
                    viewModel: .init(position: viewModel.$position)
                )
            },
            header:  {
                Text(LocalizedString.skillsetAndPositionHeader)
            },
            footer: { footerViewContent }
        )
    }
    
    private var footerViewContent: some View {
        viewModel.isAddingPlayer ? Text(LocalizedString.skillsetAndPositionFooter) : nil
    }
    
}
