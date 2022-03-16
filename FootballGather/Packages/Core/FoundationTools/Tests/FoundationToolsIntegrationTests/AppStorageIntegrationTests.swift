//
//  AppStorageIntegrationTests.swift
//  
//
//  Created by Radu Dan on 15.03.2022.
//

import XCTest
import CoreModels
import FoundationMocks
@testable import FoundationTools

final class AppStorageIntegrationTests: XCTestCase {
    
    func testMakeAppStorage_isEmpty() {
        let sut = Mocks.makeAppStorage().storage
        
        XCTAssertNil(sut.load(forKey: Mocks.storageKey))
    }
    
    func testMakeAppStorage_whenHasData_isNotNil() {
        let sut = Mocks.makeAppStorage(populated: true)
        
        XCTAssertNotNil(
            sut.storage.load(forKey: Mocks.storageKey)
        )
        sut.clear()
    }
    
    func testAddPlayersToStorage_whenHasGathers_updatesStorage() {
        let sut = Mocks.makeAppStorage()
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
        let sut = Mocks.makeAppStorage()
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
    
}
