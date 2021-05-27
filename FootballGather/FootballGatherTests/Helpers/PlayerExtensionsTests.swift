//
//  PlayerExtensionsTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 27.05.2021.
//

import XCTest
import CoreModels
@testable import FootballGather

final class PlayerExtensionsTests: XCTestCase {
    
    func testDemoPlayers() {
        let sut = Player.demoPlayers
        XCTAssertFalse(sut.isEmpty)
    }
    
}
