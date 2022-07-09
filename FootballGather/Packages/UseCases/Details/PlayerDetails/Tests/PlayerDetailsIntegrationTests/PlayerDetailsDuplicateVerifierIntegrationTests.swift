//
//  PlayerDetailsDuplicateVerifierIntegrationTests.swift
//  
//
//  Created by Radu Dan on 16.03.2022.
//

import XCTest
import CoreModels
import FoundationMocks
@testable import PlayerDetails

final class PlayerDetailsDuplicateVerifierIntegrationTests: XCTestCase {
    
    private var sut: PlayerDetailsDuplicateVerifier!
    private let allPositions = Player.Position.allCases
    private let allSkills = Player.Skill.allCases
    
    override func setUp() {
        super.setUp()
        sut = PlayerDetailsDuplicateVerifier(storage: Mocks.storage)
    }
    
    override func tearDown() {
        Mocks.storage.clear()
        super.tearDown()
    }
    
    func testSameDetailsEntered_isTrue() {
        let player = Player(
            name: "John",
            position: Player.Position.midfielder,
            skill: Player.Skill.amateur
        )
        Mocks.storage.updatePlayer(player)
        
        XCTAssertTrue(sut.sameDetailsEntered(for: player))
    }
    
    func testSameDetailsEntered_whenStoredPlayerIsDifferent_isFalse() {
        let player = Player(name: "Jane")
        Mocks.storage.updatePlayer(player)
        
        XCTAssertFalse(sut.sameDetailsEntered(for: Player(name: "Jane")))
    }
    
    func testSameDetailsEntered_whenNameIsDifferent_isFalse() {
        var player = Player(name: "Jane")
        Mocks.storage.updatePlayer(player)
        
        player.name = "Jane2"
        
        XCTAssertFalse(sut.sameDetailsEntered(for: player))
    }
    
    func testSameDetailsEntered_whenNameIsTheSame_isTrue() {
        var player = Player(name: "Jane")
        Mocks.storage.updatePlayer(player)
        
        player.name = "Jane"
        
        XCTAssertTrue(sut.sameDetailsEntered(for: player))
    }
    
    func testSameDetailsEntered_whenPositionIsDifferent_isFalse() {
        let initialPosition = Player.Position.midfielder
        var player = Player(name: "Jane", position: initialPosition)
        Mocks.storage.updatePlayer(player)
        
        let remainingPositions = allPositions.filter { $0 != initialPosition }
        
        remainingPositions.forEach { position in
            player.position = position
            XCTAssertFalse(sut.sameDetailsEntered(for: player))
        }
    }
    
    func testSameDetailsEntered_whenPositionIsSetToTheSamePosition_isTrue() {
        let position = Player.Position.winger
        var player = Player(
            name: "Thomas",
            position: position
        )
        Mocks.storage.updatePlayer(player)
        
        player.position = position
        
        XCTAssertTrue(sut.sameDetailsEntered(for: player))
    }
    
    func testSameDetailsEntered_whenSkillIsDifferent_isFalse() {
        let initialSkill = Player.Skill.amateur
        var player = Player(name: "Jane", skill: initialSkill)
        Mocks.storage.updatePlayer(player)
        
        let remainingSkills = allSkills.filter { $0 != initialSkill }
        
        remainingSkills.forEach { skill in
            player.skill = skill
            XCTAssertFalse(sut.sameDetailsEntered(for: player))
        }
    }
    
    func testSameDetailsEntered_whenSkillIsSetToTheSameSkill_isTrue() {
        let skill = Player.Skill.amateur
        var player = Player(
            name: "Thomas",
            skill: skill
        )
        Mocks.storage.updatePlayer(player)
        
        player.skill = skill
        
        XCTAssertTrue(sut.sameDetailsEntered(for: player))
    }
    
}
