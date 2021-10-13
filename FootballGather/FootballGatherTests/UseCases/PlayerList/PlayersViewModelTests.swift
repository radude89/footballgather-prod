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
        Mocks.storage.clear()
        super.tearDown()
    }
    
    func testHasPlayers_whenStorageIsEmpty_isFalse() {
        XCTAssertFalse(sut.hasPlayers)
    }
    
    func testHasPlayers_whenStorageIsNotEmpty_isTrue() {
        sut.storage.updatePlayer(Player(name: "John"))
        XCTAssertTrue(sut.hasPlayers)
    }
    
    func testStoredPlayers_whenStorageIsEmpty_isEmpty() {
        XCTAssertTrue(sut.storedPlayers.isEmpty)
    }
    
    func testStoredPlayers_whenStorageIsNotEmpty_isNotEmpty() {
        sut.storage.updatePlayer(.demo)
        XCTAssertFalse(sut.storedPlayers.isEmpty)
    }
    
    func testAddPlayers_updatesStorage() {
        sut.storage.updatePlayer(.demo)
        XCTAssertFalse(sut.storedPlayers.isEmpty)
    }
    
    func testToggleEditing() {
        XCTAssertFalse(sut.isEditing)
        sut.toggleEditing()
        XCTAssertTrue(sut.isEditing)
    }
    
}
