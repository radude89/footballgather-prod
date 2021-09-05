//
//  StorageTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 27.05.2021.
//

import XCTest
import CoreModels
@testable import FootballGather

final class StorageTests: XCTestCase {
    
    func testStorage() {
        XCTAssertEqual(Storage.defaultAppKey, "com.footballgather.storage")
    }
    
    func testStoredObject() {
        let sut = StoredObject()
        XCTAssertTrue(sut.players.isEmpty)
    }
    
    func testStoredObject_whenPlayersAreSet_setsPlayers() {
        let sut = StoredObject(players: .demoPlayers)
        XCTAssertEqual(sut.players, .demoPlayers)
    }
    
}
