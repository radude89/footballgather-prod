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
import FoundationTools
@testable import PlayerList

@MainActor
final class PlayersViewModelTests: XCTestCase {

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

    func testOnTapSupportButton_whenCanOpenURL_thenCallsURLOpener() async {
        let urlOpener = MockURLOpener(canOpenURL: true)
        let sut = makeSUT(players: .demoPlayers, urlOpener: urlOpener)

        await sut.onTapSupportButton()

        XCTAssertTrue(urlOpener.hasCalledOpenURL)
    }

    func testOnTapSupportButton_whenCanNotOpenURL_thenDoesNotCallURLOpener() async {
        let urlOpener = MockURLOpener(canOpenURL: false)
        let sut = makeSUT(players: .demoPlayers, urlOpener: urlOpener)

        await sut.onTapSupportButton()

        XCTAssertFalse(urlOpener.hasCalledOpenURL)
    }

    // MARK: - Helpers
    
    private func makeSUT(
        players: [Player] = [],
        urlOpener: any URLOpener = MockURLOpener(canOpenURL: true)
    ) -> PlayersViewModel {
        .init(
            storage: Mocks.PlayerStorageHandler(storedPlayers: players),
            urlOpener: urlOpener
        )
    }
    
}

// MARK: - Mocks

private final class MockURLOpener: URLOpener {
    private let canOpenURL: Bool
    private(set) var hasCalledOpenURL = false

    init(canOpenURL: Bool) {
        self.canOpenURL = canOpenURL
    }

    func canOpenURL(_ url: URL) -> Bool {
        canOpenURL
    }

    func openURL(_ url: URL) async {
        hasCalledOpenURL = true
    }
}
