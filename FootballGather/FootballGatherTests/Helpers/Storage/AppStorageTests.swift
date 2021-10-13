//
//  AppStorageTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 27.05.2021.
//

import XCTest
import FoundationTools
import CoreModels
@testable import FootballGather

final class AppStorageTests: XCTestCase {
    
    func testAppStorage_whenIsNotRunningUITests_doesNotStorePlayers() {
        let sut = AppStorage(
            storageKey: Mocks.storageKey,
            commandLineHandler: Mocks.CommandRunner()
        )
        XCTAssertTrue(sut.storedPlayers.isEmpty)
    }
    
    func testAppStorage_whenIsRunningUITests_doesNotStorePlayers() {
        let sut = AppStorage(
            storageKey: Mocks.storageKey,
            commandLineHandler: Mocks.CommandRunner(isRunningUITests: true)
        )
        XCTAssertTrue(sut.storedPlayers.isEmpty)
    }
    
    func testAppStorage_whenIsRunningUITestsAndShouldPopulateStorage_storesPlayers() {
        let sut = AppStorage(
            storageKey: Mocks.storageKey,
            commandLineHandler: Mocks.CommandRunner(
                isRunningUITests: true,
                shouldPopulateStorage: true
            )
        )
        XCTAssertFalse(sut.storedPlayers.isEmpty)
    }
    
    func testAppStorage_addPlayer_updatesStorage() {
        let sut = AppStorage(
            storageKey: Mocks.storageKey,
            commandLineHandler: Mocks.CommandRunner()
        )
        let players: [Player] = [
            Player(name: "John Smith"),
            Player(name: "Jane Smith")
        ]
        
        players.forEach { sut.updatePlayer($0) }
        
        XCTAssertEqual(sut.storedPlayers, players)
    }
    
}
