//
//  GatherPlayersViewModelTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 24.11.2021.
//

import XCTest
import CoreModels
@testable import Gather

final class GatherPlayersViewModelTests: XCTestCase {
    
    @MainActor
    func testPlayersInTeam_returnsCorrectPlayers() {
        let sut = GatherPlayersViewModel(
            playersTeams: [.teamA: .demoPlayers, .teamB: .demoPlayers]
        )
        
        XCTAssertEqual(sut.players(in: .teamA), .demoPlayers)
        XCTAssertEqual(sut.players(in: .teamB), .demoPlayers)
        XCTAssertTrue(sut.players(in: .bench).isEmpty)
    }
    
    @MainActor
    func testSectionNameForTeam_returnsCorrectTeam() {
        let sut = GatherPlayersViewModel(
            playersTeams: [.teamA: .demoPlayers, .teamB: .demoPlayers]
        )
        
        XCTAssertEqual(
            sut.sectionName(for: .teamA), Team.teamA.name.uppercased()
        )
        XCTAssertEqual(
            sut.sectionName(for: .teamB), Team.teamB.name.uppercased()
        )
    }
    
}
