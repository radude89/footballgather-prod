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
    
    @MainActor
    func testHasPlayers_whenStorageIsEmpty_isFalse() {
        XCTAssertFalse(makeSUT().hasPlayers)
    }
    
    @MainActor
    func testHasPlayers_whenStorageIsNotEmpty_isTrue() {
        XCTAssertTrue(makeSUT(players: .demoPlayers).hasPlayers)
    }
    
    @MainActor
    func testStoredPlayers_whenStorageIsEmpty_isEmpty() {
        XCTAssertTrue(makeSUT().storedPlayers.isEmpty)
    }
    
    @MainActor
    func testStoredPlayers_whenStorageIsNotEmpty_isNotEmpty() {
        XCTAssertFalse(makeSUT(players: .demoPlayers).storedPlayers.isEmpty)
    }
    
    // MARK: - Helpers
    
    @MainActor
    private func makeSUT(
        players: [Player] = []
    ) -> PlayersViewModel {
        .init(storage: Mocks.PlayerStorageHandler(storedPlayers: players))
    }
    
}
