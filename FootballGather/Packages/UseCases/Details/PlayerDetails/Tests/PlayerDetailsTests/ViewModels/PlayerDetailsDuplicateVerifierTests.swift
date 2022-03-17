//
//  PlayerDetailsDuplicateVerifierTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 14.10.2021.
//

import XCTest
import CoreModels
import FoundationTools
import FoundationMocks
@testable import PlayerDetails

final class PlayerDetailsDuplicateVerifierTests: XCTestCase {
    
    private let allPositions = Player.Position.allCases
    private let allSkills = Player.Skill.allCases
    
    func testSameDetailsEntered_isTrue() {
        let player = Player(
            name: "John",
            position: allPositions.randomElement(),
            skill: allSkills.randomElement()
        )
        let sut = makeSUT(players: [player])
        
        XCTAssertTrue(sut.sameDetailsEntered(for: player))
    }
    
    func testSameDetailsEntered_whenStoredPlayerIsDifferent_isFalse() {
        let player = Player(name: "Jane")
        let sut = makeSUT(players: [player])
        
        XCTAssertFalse(sut.sameDetailsEntered(for: Player(name: "Jane")))
    }
    
    func testSameDetailsEntered_whenStorageIsEmpty_isFalse() {
        XCTAssertFalse(
            makeSUT().sameDetailsEntered(for: Player(name: "Jerome"))
        )
    }
    
    func testSameDetailsEntered_whenNameIsDifferent_isFalse() {
        var player = Player(name: "Jane")
        let sut = makeSUT(players: [player])
        
        player.name = "Jane2"
        
        XCTAssertFalse(sut.sameDetailsEntered(for: player))
    }
    
    func testSameDetailsEntered_whenNameIsTheSame_isTrue() {
        var player = Player(name: "Jane")
        let sut = makeSUT(players: [player])
        
        player.name = "Jane"
        
        XCTAssertTrue(sut.sameDetailsEntered(for: player))
    }
    
    func testSameDetailsEntered_whenPositionIsDifferent_isFalse() {
        let initialPosition = allPositions.randomElement()
        var player = Player(name: "Jane", position: initialPosition)
        let sut = makeSUT(players: [player])
        
        let remainingPositions = allPositions.filter { $0 != initialPosition }
        
        remainingPositions.forEach { position in
            player.position = position
            XCTAssertFalse(sut.sameDetailsEntered(for: player))
        }
    }
    
    func testSameDetailsEntered_whenPositionIsInitiallyNil_isFalse() {
        var player = Player(name: "Goblin")
        let sut = makeSUT(players: [player])
        
        allPositions.forEach { position in
            player.position = position
            XCTAssertFalse(sut.sameDetailsEntered(for: player))
        }
    }
    
    func testSameDetailsEntered_whenPositionIsSetToNil_isFalse() {
        var player = Player(
            name: "Tim",
            position: allPositions.randomElement()
        )
        let sut = makeSUT(players: [player])
        
        player.position = nil
        
        XCTAssertFalse(sut.sameDetailsEntered(for: player))
    }
    
    func testSameDetailsEntered_whenPositionIsSetToTheSamePosition_isTrue() {
        let position = allPositions.randomElement()
        var player = Player(
            name: "Thomas",
            position: position
        )
        let sut = makeSUT(players: [player])
        
        player.position = position
        
        XCTAssertTrue(sut.sameDetailsEntered(for: player))
    }
    
    func testSameDetailsEntered_whenSkillIsDifferent_isFalse() {
        let initialSkill = allSkills.randomElement()
        var player = Player(name: "Jane", skill: initialSkill)
        let sut = makeSUT(players: [player])
        
        let remainingSkills = allSkills.filter { $0 != initialSkill }
        
        remainingSkills.forEach { skill in
            player.skill = skill
            XCTAssertFalse(sut.sameDetailsEntered(for: player))
        }
    }
    
    func testSameDetailsEntered_whenSkillIsInitiallyNil_isFalse() {
        var player = Player(name: "Goblin")
        let sut = makeSUT(players: [player])
        
        allSkills.forEach { skill in
            player.skill = skill
            XCTAssertFalse(sut.sameDetailsEntered(for: player))
        }
    }
    
    func testSameDetailsEntered_whenSkillIsSetToNil_isFalse() {
        var player = Player(
            name: "Tim",
            skill: allSkills.randomElement()
        )
        let sut = makeSUT(players: [player])
        
        player.skill = nil
        
        XCTAssertFalse(sut.sameDetailsEntered(for: player))
    }
    
    func testSameDetailsEntered_whenSkillIsSetToTheSameSkill_isTrue() {
        let skill = allSkills.randomElement()
        var player = Player(
            name: "Thomas",
            skill: skill
        )
        let sut = makeSUT(players: [player])
        
        player.skill = skill
        
        XCTAssertTrue(sut.sameDetailsEntered(for: player))
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        players: [Player] = []
    ) -> PlayerDetailsDuplicateVerifier {
        .init(storage: Mocks.PlayerStorageHandler(storedPlayers: players))
    }
    
}
