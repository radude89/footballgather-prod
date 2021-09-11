//
//  SkillAndPositionSection.swift
//  SkillAndPositionSection
//
//  Created by Radu Dan on 11.09.2021.
//

import SwiftUI
import Localizable

struct SkillAndPositionSection: View {
    
    let viewModel: SkillAndPositionSectionViewModel
    
    var body: some View {
        Section(
            content: {
                SkillPickerView(viewModel: .init(skill: viewModel.$skill))
                PositionPickerView(viewModel: .init(position: viewModel.$position))
            },
            header:  {
                Text(LocalizedString.sectionSkillsetHeader)
            },
            footer: {
                Text(LocalizedString.sectionSkillsetFooter)
            }
        )
    }
    
}

struct SkillAndPositionSection_Previews: PreviewProvider {
    static var previews: some View {
        SkillAndPositionSection(viewModel: .init(
            skill: .constant(.amateur),
            position: .constant(.forward))
        )
    }
}
