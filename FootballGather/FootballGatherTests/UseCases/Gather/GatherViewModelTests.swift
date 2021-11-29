//
//  GatherViewModelTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 29.11.2021.
//

import XCTest
import CoreModels
@testable import FootballGather

final class GatherViewModelTests: XCTestCase {
    
    func testInit() {
        let sut = GatherViewModel(
            playersTeams: [.teamA: .demoPlayers, .teamB: .demoPlayers]
        )
        
        XCTAssertEqual(sut.playersTeams[.teamA], .demoPlayers)
        XCTAssertEqual(sut.playersTeams[.teamB], .demoPlayers)
        XCTAssertNil(sut.playersTeams[.bench])
    }
    
}
