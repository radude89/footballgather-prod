//
//  DemoModelsTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 27.05.2021.
//

import XCTest
import CoreModels
@testable import FootballGather

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
