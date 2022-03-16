//
//  AppStorageFactoryTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 27.05.2021.
//

import XCTest
import CoreModels
import FoundationMocks
@testable import FoundationTools

final class AppStorageFactoryTests: XCTestCase {
    
    func testMakeAppStorage_whenIsRunningTests_loadsStorage() {
        let sut = AppStorageAssembler(
            commandLineHandler: Mocks.CommandRunner(isRunningUITests: true)
        )
        let storage = sut.makeAppStorage()
        
        storage.store(Mocks.storedObject, at: Mocks.storageKey)
        XCTAssertNotNil(storage.load(forKey: Mocks.storageKey))
        
        storage.clear()
        XCTAssertNil(storage.load(forKey: Mocks.storageKey))
    }
    
    func testMakeAppStorage_whenIsNotRunningTests_loadsStorage() {
        let sut = AppStorageAssembler(
            commandLineHandler: Mocks.CommandRunner(isRunningUITests: false)
        )
        let storage = sut.makeAppStorage()
        
        storage.store(Mocks.storedObject, at: Mocks.storageKey)
        XCTAssertNotNil(storage.load(forKey: Mocks.storageKey))
        
        storage.clear()
        XCTAssertNil(storage.load(forKey: Mocks.storageKey))
    }
    
}
