//
//  TeamTests.swift
//  
//
//  Created by Radu Dan on 26.10.2021.
//

import XCTest
@testable import CoreModels

final class TeamTests: XCTestCase {
    
    func testNames() {
        XCTAssertEqual(Team.bench.name, "Bench")
        XCTAssertEqual(Team.teamA.name, "Team A")
        XCTAssertEqual(Team.teamB.name, "Team B")
    }
    
}
