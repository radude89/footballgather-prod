//
//  DemoModelsTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 27.05.2021.
//

import XCTest
@testable import CoreModels

final class DemoModelsTests: XCTestCase {
    
    func testDemoPlayers_areNotEmpty() {
        XCTAssertFalse(Player.demoPlayers.isEmpty)
    }
    
    func testDemoPlayer_isRandomizedFromTheCollection() {
        XCTAssertTrue(Player.demoPlayers.contains(Player.demo))
        XCTAssertTrue(Player.demoPlayers.contains(Array.demoPlayer))
    }
    
    func testDemoGathers_areNotEmpty() {
        XCTAssertFalse(Gather.demoGathers.isEmpty)
        XCTAssertFalse(Array.demoGathers.isEmpty)
    }
    
}
