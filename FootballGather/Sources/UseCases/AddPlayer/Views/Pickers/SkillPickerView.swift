//
//  SkillPickerView.swift
//  SkillPickerView
//
//  Created by Radu Dan on 11.09.2021.
//

import SwiftUI
import Localizable
import CoreModels

struct SkillPickerView: View {
    
    let viewModel: SkillPickerViewModel
    
    var body: some View {
        Picker(
            LocalizedString.skill,
            selection: viewModel.$skill
        ) {
            ForEach(viewModel.allSkills, id: \.self) { skill in
                Text(SkillPickerViewModel.skillRowDescription(skill))
                    .tag(skill as Player.Skill?)
            }
        }
    }
    
}

struct SkillPickerView_Previews: PreviewProvider {
    static var previews: some View {
        SkillPickerView(viewModel: .init(skill: .constant(.amateur)))
    }
}
