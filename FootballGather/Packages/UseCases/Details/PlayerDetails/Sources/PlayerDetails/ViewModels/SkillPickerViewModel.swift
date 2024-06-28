//
//  SkillPickerViewModel.swift
//  SkillPickerViewModel
//
//  Created by Radu Dan on 11.09.2021.
//

import SwiftUI
import CoreModels

@MainActor
struct SkillPickerViewModel {
    
    @Binding var skill: Player.Skill
    
    let allSkills: [Player.Skill]
    
    init(
        skill: Binding<Player.Skill>,
        allSkills: [Player.Skill] = Player.Skill.allCases
    ) {
        _skill = skill
        self.allSkills = allSkills
    }
    
    static func skillRowDescription(_ skill: Player.Skill) -> String {
        skill.rawValue.capitalized
    }
    
}
