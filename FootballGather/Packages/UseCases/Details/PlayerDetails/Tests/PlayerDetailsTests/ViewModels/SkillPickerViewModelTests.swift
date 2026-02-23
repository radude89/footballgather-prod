//
//  SkillPickerViewModelTests.swift
//  SkillPickerViewModelTests
//
//  Created by Radu Dan on 12.09.2021.
//

import XCTest
import SwiftUI
import CoreModels
@testable import PlayerDetails

@MainActor
final class SkillPickerViewModelTests: XCTestCase {
    
    private let skills = Player.Skill.allCases
    
    func testSkillBinding() {
        skills.forEach { skill in
            let skillBinding = Binding<Player.Skill> {
                .unknown
            } set: { newValue in
                XCTAssertEqual(newValue, skill)
            }
            
            SkillPickerViewModel(skill: skillBinding).skill = skill
        }
    }
    
    func testAllSkills() {
        let sut = SkillPickerViewModel(skill: .constant(.unknown))
        XCTAssertEqual(sut.allSkills, skills)
    }
    
    func testSkillRowDescription_capitalizesValue() {
        skills.forEach { skill in
            XCTAssertEqual(
                SkillPickerViewModel.skillRowDescription(skill),
                skill.rawValue.capitalized
            )
        }
    }
    
}
