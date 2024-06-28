//
//  SkillPickerView.swift
//  SkillPickerView
//
//  Created by Radu Dan on 11.09.2021.
//

import SwiftUI
import PlayerDetailsAssets
import CoreModels

struct SkillPickerView: View {
    
    private let viewModel: SkillPickerViewModel
    
    init(viewModel: SkillPickerViewModel) {
        self.viewModel = viewModel
    }
    
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
        .pickerStyle(.automatic)
    }
    
}
