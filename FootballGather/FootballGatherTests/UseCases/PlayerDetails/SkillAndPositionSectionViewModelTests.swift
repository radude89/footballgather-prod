//
//  SkillAndPositionSectionViewModelTests.swift
//  SkillAndPositionSectionViewModelTests
//
//  Created by Radu Dan on 12.09.2021.
//

import XCTest
import SwiftUI
import CoreModels
@testable import FootballGather

final class SkillAndPositionSectionViewModelTests: XCTestCase {
    
    private let skills = Player.Skill.allCases
    private let positions = Player.Position.allCases
    
    func testSkillAndPosition_whenNotNil() {
        skills.forEach { skill in
            let skillBinding = Binding<Player.Skill?> {
                nil
            } set: { newSkill in
                XCTAssertEqual(newSkill, skill)
            }
            
            positions.forEach { position in
                let positionBinding = Binding<Player.Position?> {
                    nil
                } set: { newPosition in
                    XCTAssertEqual(newPosition, position)
                }
                
                let sut = SkillAndPositionSectionViewModel(
                    skill: skillBinding,
                    position: positionBinding
                )
                
                sut.skill = skill
                sut.position = position
            }
        }
    }
    
    func testSkillAndPosition_whenNil() {
        let sut = SkillAndPositionSectionViewModel(
            skill: .constant(nil),
            position: .constant(nil)
        )
        
        XCTAssertNil(sut.skill)
        XCTAssertNil(sut.position)
    }
    
}
