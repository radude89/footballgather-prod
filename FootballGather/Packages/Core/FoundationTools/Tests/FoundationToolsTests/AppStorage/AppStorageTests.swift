//
//  AppStorageTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 27.05.2021.
//

import XCTest
import CoreModels
import FoundationMocks
@testable import FoundationTools

final class AppStorageTests: XCTestCase {
    
    override func tearDown() {
        Mocks.storage.clear()
        super.tearDown()
    }
    
    func testAppStorage_whenIsNotRunningUITests_doesNotStorePlayers() {
        XCTAssertTrue(makeSUT().storedPlayers.isEmpty)
    }
    
    func testAppStorage_whenIsRunningUITests_doesNotStorePlayers() {
        XCTAssertTrue(makeSUT(isRunningUITests: true).storedPlayers.isEmpty)
    }
    
    func testAppStorage_whenIsNotRunningUITests_doesNotStoreGathers() {
        XCTAssertTrue(makeSUT().gathers.isEmpty)
    }
    
    func testAppStorage_whenIsRunningUITests_doesNotStoreGathers() {
        XCTAssertTrue(makeSUT(isRunningUITests: true).gathers.isEmpty)
    }
    
    func testAppStorage_whenIsRunningUITestsAndShouldPopulateStorage_storesPlayers() {
        let sut = makeSUT(isRunningUITests: true, shouldPopulateStorage: true)

        XCTAssertFalse(sut.storedPlayers.isEmpty)
        sut.clear()
    }
    
    func testAppStorage_addPlayer_updatesStorage() {
        let sut = makeSUT()

        let players = [
            Player(name: "John Smith"),
            Player(name: "Jane Smith")
        ]
        
        players.forEach { sut.updatePlayer($0) }
        
        XCTAssertEqual(sut.storedPlayers, players)
        sut.clear()
    }
    
    func testAppStorage_addGather_updatesStorage() {
        let sut = makeSUT()
        let gathers = Gather.demoGathers
        
        gathers.forEach { sut.addGather($0) }
        
        XCTAssertEqual(sut.gathers, gathers)
        sut.clear()
    }
    
    func testClear() {
        let sut = makeSUT()
        let gathers = Gather.demoGathers
        let players = Player.demoPlayers
        
        gathers.forEach { sut.addGather($0) }
        players.forEach { sut.updatePlayer($0) }
        
        sut.clear()
        
        XCTAssertTrue(sut.storedPlayers.isEmpty)
        XCTAssertTrue(sut.gathers.isEmpty)
    }
    
    func testDeletePlayers() {
        let sut = makeSUT()
        let player = Player(name: "John Smith")
        sut.updatePlayer(player)
        
        sut.deletePlayer(player)
        
        XCTAssertTrue(sut.storedPlayers.isEmpty)
    }
    
    func testDeletePlayers_whenStorageIsEmpty_returns() {
        let sut = makeSUT()
        
        sut.deletePlayer(Player(name: "John Smith"))
        
        XCTAssertTrue(sut.storedPlayers.isEmpty)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        isRunningUITests: Bool = false,
        shouldPopulateStorage: Bool = false
    ) -> AppStorage {
        let commandLineHandler = Mocks.CommandRunner(isRunningUITests: true)
        let assembler = AppStorageAssembler(commandLineHandler: commandLineHandler)
        
        return AppStorage(
            storageKey: Mocks.storageKey,
            storageFactory: assembler,
            commandLineHandler: Mocks.CommandRunner(
                isRunningUITests: isRunningUITests,
                shouldPopulateStorage: shouldPopulateStorage
            )
        )
    }
    
}
