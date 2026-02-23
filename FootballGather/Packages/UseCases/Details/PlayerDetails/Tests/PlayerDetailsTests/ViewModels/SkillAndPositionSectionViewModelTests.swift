//
//  SkillAndPositionSectionViewModelTests.swift
//  SkillAndPositionSectionViewModelTests
//
//  Created by Radu Dan on 12.09.2021.
//

import XCTest
import SwiftUI
import CoreModels
@testable import PlayerDetails

@MainActor
final class SkillAndPositionSectionViewModelTests: XCTestCase {
    
    private let skills = Player.Skill.allCases
    private let positions = Player.Position.allCases
    
    func testSkillAndPosition() {
        skills.forEach { skill in
            let skillBinding = Binding<Player.Skill> {
                .unknown
            } set: { newSkill in
                XCTAssertEqual(newSkill, skill)
            }
            
            positions.forEach { position in
                let positionBinding = Binding<Player.Position> {
                    .unknown
                } set: { newPosition in
                    XCTAssertEqual(newPosition, position)
                }
                
                let sut = SkillAndPositionSectionViewModel(
                    skill: skillBinding,
                    position: positionBinding,
                    isAddingPlayer: true
                )
                
                sut.skill = skill
                sut.position = position
            }
        }
    }
    
}
