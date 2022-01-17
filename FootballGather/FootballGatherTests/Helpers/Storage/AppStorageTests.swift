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
    
    func testAppStorage_whenIsNotRunningUITests_doesNotStoreGathers() {
        let sut = AppStorage(
            storageKey: Mocks.storageKey,
            commandLineHandler: Mocks.CommandRunner()
        )
        XCTAssertTrue(sut.gathers.isEmpty)
    }
    
    func testAppStorage_whenIsRunningUITests_doesNotStoreGathers() {
        let sut = AppStorage(
            storageKey: Mocks.storageKey,
            commandLineHandler: Mocks.CommandRunner(isRunningUITests: true)
        )
        XCTAssertTrue(sut.gathers.isEmpty)
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
        let players = [
            Player(name: "John Smith"),
            Player(name: "Jane Smith")
        ]
        
        players.forEach { sut.updatePlayer($0) }
        
        XCTAssertEqual(sut.storedPlayers, players)
    }
    
    func testAppStorage_addGather_updatesStorage() {
        let gathers = Gather.demoGathers
        let sut = AppStorage(
            storageKey: Mocks.storageKey,
            commandLineHandler: Mocks.CommandRunner()
        )
        
        gathers.forEach { sut.addGather($0) }
        
        XCTAssertEqual(sut.gathers, gathers)
    }
    
    func testClear() {
        let gathers = Gather.demoGathers
        let players = Player.demoPlayers
        let sut = AppStorage(
            storageKey: Mocks.storageKey,
            commandLineHandler: Mocks.CommandRunner()
        )
        
        gathers.forEach { sut.addGather($0) }
        players.forEach { sut.updatePlayer($0) }
        
        sut.clear()
        
        XCTAssertTrue(sut.storedPlayers.isEmpty)
        XCTAssertTrue(sut.gathers.isEmpty)
    }
    
    func testDeletePlayers() {
        let sut = AppStorage(
            storageKey: Mocks.storageKey,
            commandLineHandler: Mocks.CommandRunner()
        )
        let player = Player(name: "John Smith")
        sut.updatePlayer(player)
        
        sut.deletePlayer(player)
        
        XCTAssertTrue(sut.storedPlayers.isEmpty)
    }
    
    func testDeletePlayers_whenStorageIsEmpty_returns() {
        let sut = AppStorage(
            storageKey: Mocks.storageKey,
            commandLineHandler: Mocks.CommandRunner()
        )
        
        sut.deletePlayer(Player(name: "John Smith"))
        
        XCTAssertTrue(sut.storedPlayers.isEmpty)
    }
    
}
