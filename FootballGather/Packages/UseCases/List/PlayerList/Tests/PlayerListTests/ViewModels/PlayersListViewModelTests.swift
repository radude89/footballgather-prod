//
//  PlayersListViewModelTests.swift
//  PlayersListViewModelTests
//
//  Created by Radu Dan on 05.09.2021.
//

import XCTest
import SwiftUI
import CoreModels
import FoundationMocks
import FoundationTools
@testable import PlayerList

final class PlayersListViewModelTests: XCTestCase {
    
    func testFormattedRowTitle_isPlayerName() {
        let name = "Jane"
        
        XCTAssertEqual(
            PlayersListViewModel.formattedRowTitle(for: Player(name: name)),
            name
        )
    }
    
    func testFormattedRowTitle_whenNameIsEmpty_isEmpty() {
        let name = ""
        let sut = PlayersListViewModel.formattedRowTitle(for: Player(name: name))
        
        XCTAssertEqual(sut, name)
        XCTAssertTrue(sut.isEmpty)
    }
    
    func testFormattedRowTitle_whenNameContainsEmojis_returnsName() {
        let name = "🚀John☎️ Doe☘️"
        
        XCTAssertEqual(
            PlayersListViewModel.formattedRowTitle(for: Player(name: name)),
            name
        )
    }
    
    func testFormattedRowTitle_whenNameContainsDigitsAndSpecialCharacters_returnsName() {
        let name = "123 $$@@!@#*&$#(*_)"
        
        XCTAssertEqual(
            PlayersListViewModel.formattedRowTitle(for: Player(name: name)),
            name
        )
    }
    
    func testDeletePlayer() {
        let storage = Mocks.PlayerStorageHandler(
            storedPlayers: [.demo]
        )
        let sut = makeSUT(storage: storage)
        
        sut.delete(.demo)
        
        XCTAssertTrue(storage.deletePlayerCalled)
    }
    
    func testDeleteAt() {
        let storage = Mocks.PlayerStorageHandler(
            storedPlayers: [.demo]
        )
        let sut = makeSUT(storage: storage)
        
        sut.delete(at: .init(integer: 0))
        
        XCTAssertTrue(storage.deletePlayerCalled)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        storage: PlayerStorageHandler = Mocks.PlayerStorageHandler(),
        showListView: Binding<Bool> = .constant(false)
    ) -> PlayersListViewModel {
        .init(
            storage: storage,
            showListView: showListView
        )
    }
    
}
