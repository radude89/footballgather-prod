//
//  SkillAndPositionSectionViewModel.swift
//  SkillAndPositionSectionViewModel
//
//  Created by Radu Dan on 11.09.2021.
//

import SwiftUI
import CoreModels

struct SkillAndPositionSectionViewModel {
    @Binding var skill: Player.Skill
    @Binding var position: Player.Position
    let isAddingPlayer: Bool
}
