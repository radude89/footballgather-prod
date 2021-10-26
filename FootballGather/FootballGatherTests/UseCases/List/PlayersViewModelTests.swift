//
//  PlayersViewModelTests.swift
//  PlayersViewModelTests
//
//  Created by Radu Dan on 05.09.2021.
//

import XCTest
import CoreModels
import Combine
@testable import FootballGather

final class PlayersViewModelTests: XCTestCase {
    
    private var sut: PlayersViewModel!
    private var cancellable: AnyCancellable?
    
    override func setUp() {
        super.setUp()
        sut = PlayersViewModel(storage: Mocks.storage)
    }
    
    override func tearDown() {
        Mocks.storage.clear()
        cancellable = nil
        
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
    
    func testToggleSelection() {
        XCTAssertFalse(sut.isSelectingPlayers)
        
        sut.toggleSelection()
        
        XCTAssertTrue(sut.isSelectingPlayers)
    }
    
    func testToggleSelection_clearsSelectedRows() {
        sut.isSelectingPlayers = true
        sut.selectedRows.insert(UUID())
        
        sut.toggleSelection()
        
        XCTAssertTrue(sut.selectedRows.isEmpty)
    }
    
    func testReloadView() {
        let reloadViewExpectation = expectation(description: "Reload view expectation")
        cancellable = sut.objectWillChange.sink { _ in
            reloadViewExpectation.fulfill()
        }
        
        sut.reloadView()
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
}
