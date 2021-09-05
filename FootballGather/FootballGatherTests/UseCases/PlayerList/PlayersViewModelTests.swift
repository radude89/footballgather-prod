//
//  PlayersViewModelTests.swift
//  PlayersViewModelTests
//
//  Created by Radu Dan on 05.09.2021.
//

import XCTest
import CoreModels
@testable import FootballGather

final class PlayersViewModelTests: XCTestCase {
    
    private var sut: PlayersViewModel!
    
    override func setUp() {
        super.setUp()
        sut = PlayersViewModel(storage: Mocks.storage)
    }
    
    override func tearDown() {
        super.tearDown()
        Mocks.storage.clear()
    }
    
    func testHasPlayers_whenStorageIsEmpty_isFalse() {
        XCTAssertFalse(sut.hasPlayers)
    }
    
    func testHasPlayers_whenStorageIsNotEmpty_isTrue() {
        Mocks.storage.updatePlayers([Player(name: "John")])
        
        XCTAssertTrue(sut.hasPlayers)
    }
    
    func testStoredPlayers_whenStorageIsEmpty_isEmpty() {
        XCTAssertTrue(sut.storedPlayers.isEmpty)
    }
    
    func testStoredPlayers_whenStorageIsNotEmpty_isNotEmpty() {
        Mocks.storage.updatePlayers(Player.demoPlayers)
        XCTAssertFalse(sut.storedPlayers.isEmpty)
    }
    
    func testAddPlayers_updatesStorage() {
        sut.addPlayers(Player.demoPlayers)
        
        XCTAssertFalse(Mocks.storage.storedPlayers.isEmpty)
    }
    
    func testToggleEditing() {
        XCTAssertFalse(sut.isEditing)
        sut.toggleEditing()
        XCTAssertTrue(sut.isEditing)
    }
    
}
