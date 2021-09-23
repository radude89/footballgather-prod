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
    
    func testDemoPlayer() {
        let sut = Player.demo
        XCTAssertTrue(Player.demoPlayers.contains(sut))
    }
    
    func testDemoPlayer_inArray() {
        let sut = Array.demoPlayer
        XCTAssertTrue(Array.demoPlayers.contains(sut))
    }
    
}
