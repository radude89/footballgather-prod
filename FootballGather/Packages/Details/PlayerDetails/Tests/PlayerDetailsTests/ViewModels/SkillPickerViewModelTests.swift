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

final class SkillPickerViewModelTests: XCTestCase {
    
    private let skills = Player.Skill.allCases
    
    func testSkillBinding_whenNotNil() {
        skills.forEach { skill in
            let skillBinding = Binding<Player.Skill?> {
                nil
            } set: { newValue in
                XCTAssertEqual(newValue, skill)
            }
            
            SkillPickerViewModel(skill: skillBinding).skill = skill
        }
    }
    
    func testSkillBinding_whenNil() {
        let sut = SkillPickerViewModel(skill: .constant(nil))
        XCTAssertNil(sut.skill)
    }
    
    func testAllSkills() {
        let sut = SkillPickerViewModel(skill: .constant(nil))
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
