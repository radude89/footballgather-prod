//
//  AppStorageIntegrationTests.swift
//  
//
//  Created by Radu Dan on 15.03.2022.
//

import XCTest
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
