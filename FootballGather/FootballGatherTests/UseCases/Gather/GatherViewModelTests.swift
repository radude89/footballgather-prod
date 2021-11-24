//
//  GatherViewModelTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 24.11.2021.
//

import XCTest
import CoreModels
@testable import FootballGather

final class GatherViewModelTests: XCTestCase {
    
    func testInit() {
        let sut = GatherViewModel(
            playersTeams: [.teamA: .demoPlayers, .teamB: .demoPlayers]
        )
        
        XCTAssertEqual(sut.players(in: .teamA), .demoPlayers)
        XCTAssertEqual(sut.players(in: .teamB), .demoPlayers)
        XCTAssertTrue(sut.players(in: .bench).isEmpty)
    }
    
}
