//
//  AppStorageIntegrationTests.swift
//  
//
//  Created by Radu Dan on 15.03.2022.
//

import XCTest
import CoreModels
@testable import FoundationTools

final class AppStorageIntegrationTests: XCTestCase {
    
    private let storageKey = "test_int_storage_key"
    
    func testMakeAppStorage_isEmpty() {
        XCTAssertNil(
            makeSUT().storage.load(forKey: storageKey)
        )
    }
    
    func testMakeAppStorage_whenHasData_isNotNil() {
        let sut = makeSUT(populateStorage: true)
        
        XCTAssertNotNil(
            sut.storage.load(forKey: storageKey)
        )
        sut.clear()
    }
    
    func testAddPlayersToStorage_whenHasGathers_updatesStorage() {
        let sut = makeSUT()
        sut.addGather(.demoGathers[0])
        
        XCTAssertFalse(sut.gathers.isEmpty)
        XCTAssertTrue(sut.storedPlayers.isEmpty)
        
        sut.updatePlayer(.demo)
        
        XCTAssertFalse(sut.gathers.isEmpty)
        XCTAssertFalse(sut.storedPlayers.isEmpty)
        
        sut.clear()
        
        XCTAssertTrue(sut.gathers.isEmpty)
        XCTAssertTrue(sut.storedPlayers.isEmpty)
    }
    
    func testAddGathersToStorage_whenHasPlayers_updatesStorage() {
        let sut = makeSUT()
        sut.updatePlayer(.demo)
        
        XCTAssertFalse(sut.storedPlayers.isEmpty)
        XCTAssertTrue(sut.gathers.isEmpty)
        
        sut.addGather(.demoGathers[0])
        
        XCTAssertFalse(sut.storedPlayers.isEmpty)
        XCTAssertFalse(sut.gathers.isEmpty)
        
        sut.clear()
        
        XCTAssertTrue(sut.storedPlayers.isEmpty)
        XCTAssertTrue(sut.gathers.isEmpty)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        populateStorage: Bool = false
    ) -> AppStorage {
        let commandLineHandler = makeCommandLineHandler(
            populateStorage: populateStorage
        )
        let assembler = AppStorageAssembler(
            commandLineHandler: commandLineHandler
        )
        
        return AppStorage(
            storageKey: storageKey,
            storageFactory: assembler,
            commandLineHandler: commandLineHandler
        )
    }
    
    private func makeCommandLineHandler(
        populateStorage: Bool = false
    ) -> CommandLineHandler {
        var commands = [Command.runUITests.rawValue]
        if populateStorage {
            commands.append(
                Command.populateStorage.rawValue
            )
        }
        
        return CommandLineHandler(
            commandLineArguments: commands
        )
    }
    
}
