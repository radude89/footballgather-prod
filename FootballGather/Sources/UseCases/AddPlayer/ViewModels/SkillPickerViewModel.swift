//
//  SkillPickerViewModel.swift
//  SkillPickerViewModel
//
//  Created by Radu Dan on 11.09.2021.
//

import SwiftUI
import CoreModels

struct SkillPickerViewModel {
    
    @Binding var skill: Player.Skill?
    
    let allSkills = Player.Skill.allCases
    
    static func skillRowDescription(_ skill: Player.Skill) -> String {
        skill.rawValue.capitalized
    }
    
}
