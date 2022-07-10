//
//  PlayersViewModelTests.swift
//  PlayersViewModelTests
//
//  Created by Radu Dan on 05.09.2021.
//

import XCTest
import Combine
import CoreModels
import FoundationMocks
@testable import PlayerList

final class PlayersViewModelTests: XCTestCase {
    
    private var cancellable: AnyCancellable?
    
    override func tearDown() {
        cancellable = nil
        super.tearDown()
    }
    
    func testHasPlayers_whenStorageIsEmpty_isFalse() {
        XCTAssertFalse(makeSUT().hasPlayers)
    }
    
    func testHasPlayers_whenStorageIsNotEmpty_isTrue() {
        XCTAssertTrue(makeSUT(players: .demoPlayers).hasPlayers)
    }
    
    func testStoredPlayers_whenStorageIsEmpty_isEmpty() {
        XCTAssertTrue(makeSUT().storedPlayers.isEmpty)
    }
    
    func testStoredPlayers_whenStorageIsNotEmpty_isNotEmpty() {
        XCTAssertFalse(makeSUT(players: .demoPlayers).storedPlayers.isEmpty)
    }
    
    func testReloadView() {
        let sut = makeSUT()
        let reloadViewExpectation = expectation(description: "Reload view expectation")
        cancellable = sut.objectWillChange.sink { _ in
            reloadViewExpectation.fulfill()
        }
        
        sut.reloadView()
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        players: [Player] = []
    ) -> PlayersViewModel {
        .init(storage: Mocks.PlayerStorageHandler(storedPlayers: players))
    }
    
}
