//
//  ConfirmPlayersViewModelTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 26.10.2021.
//

import XCTest
import CoreModels
import Localizable
@testable import FootballGather

final class ConfirmPlayersViewModelTests: XCTestCase {
    
    func testTeams_equalsAllCases() {
        let sut = ConfirmPlayersViewModel(players: [])
        XCTAssertEqual(sut.teams, Team.allCases)
    }
    
    func testSectionName_isUppercased() {
        let sut = ConfirmPlayersViewModel(players: [])
        
        Team.allCases.forEach { team in
            let sectionName = sut.sectionName(for: team)
            XCTAssertEqual(sectionName, team.name.uppercased())
        }
    }
    
    func testAccessibilityID_whenTeamIsBench_isBenchView() {
        let sut = ConfirmPlayersViewModel(players: [])
        
        XCTAssertEqual(
            sut.accessibilityID(for: .bench), .benchView
        )
    }
    
    func testAccessibilityID_whenTeamIsTeamA_isTeamAView() {
        let sut = ConfirmPlayersViewModel(players: [])
        
        XCTAssertEqual(
            sut.accessibilityID(for: .teamA), .teamAView
        )
    }
    
    func testAccessibilityID_whenTeamIsTeamB_isTeamBView() {
        let sut = ConfirmPlayersViewModel(players: [])
        
        XCTAssertEqual(
            sut.accessibilityID(for: .teamB), .teamBView
        )
    }
    
    func testPlayers_whenTeamHasPlayers_equalPlayersFromTheGivenTeam() {
        let sut = ConfirmPlayersViewModel(players: .demoPlayers)
        
        XCTAssertEqual(
            sut.players(in: .bench), Player.demoPlayers
        )
        XCTAssertTrue(sut.players(in: .teamA).isEmpty)
        XCTAssertTrue(sut.players(in: .teamB).isEmpty)
    }
    
    func testRowDescription_isPlayerName() {
        let player = Player(name: "Garry")
        let sut = ConfirmPlayersViewModel(players: [])
        
        XCTAssertEqual(sut.rowDescription(for: player), player.name)
    }
    
}
