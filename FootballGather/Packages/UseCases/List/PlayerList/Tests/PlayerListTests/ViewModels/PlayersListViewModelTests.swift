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
    
    func testHasSelected_whenRowContainsPlayerID_isTrue() {
        let player = Player.demoPlayers[0]
        let selectedRowID = player.id
        let sut = makeSUT(selectedRows: .constant([selectedRowID]))
        
        XCTAssertTrue(sut.hasSelected(player))
    }
    
    func testHasSelected_whenSelectedRowsAreEmpty_isFalse() {
        XCTAssertFalse(
            makeSUT().hasSelected(.demoPlayers[0])
        )
    }
    
    func testHasSelected_whenRowDoesNotContainPlayer_isFalse() {
        let selectedRows = Set<UUID>(
            Player.demoPlayers.map { $0.id }
        )
        let sut = makeSUT(selectedRows: .constant(selectedRows))
        
        XCTAssertFalse(
            sut.hasSelected(Player(name: "John"))
        )
    }
    
    func testHasSelected_whenAllRowsAreSelected_isTrueForAllPlayers() {
        let players = Player.demoPlayers
        let storage = Mocks.PlayerStorageHandler(storedPlayers: players)
        let selectedRows = Set<UUID>(players.map { $0.id })
        let sut = makeSUT(
            storage: storage,
            selectedRows: .constant(selectedRows)
        )
        
        players.forEach { player in
            XCTAssertTrue(sut.hasSelected(player))
        }
    }
    
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
    
    func testShouldConfirmPlayers_whenSeletedRowsAreTwo_isTrue() {
        let sut = makeSUT(
            selectedRows: .constant([UUID(), UUID()])
        )
        
        XCTAssertTrue(sut.shouldConfirmPlayers)
    }
    
    func testShouldConfirmPlayers_whenSeletedRowsAreGreaterThanTwo_isTrue() {
        let sut = makeSUT(
            selectedRows: .constant([UUID(), UUID(), UUID()])
        )
        
        XCTAssertTrue(sut.shouldConfirmPlayers)
    }
    
    func testShouldConfirmPlayers_whenSeletedRowsAreZero_isFalse() {
        XCTAssertFalse(makeSUT().shouldConfirmPlayers)
    }
    
    func testShouldConfirmPlayers_whenSeletedRowsAreOne_isFalse() {
        let sut = makeSUT(
            selectedRows: .constant([UUID()])
        )
        
        XCTAssertFalse(sut.shouldConfirmPlayers)
    }
    
    func testSelectedPlayers_whenSelectedRowsAreNotEmpty_equalsCorrectPlayers() {
        let players = Player.demoPlayers
        let storage = Mocks.PlayerStorageHandler(storedPlayers: players)
        let selectedRows = Set<UUID>(players.map { $0.id })
        let sut = makeSUT(
            storage: storage,
            selectedRows: .constant(selectedRows)
        )
        
        XCTAssertEqual(sut.selectedPlayers, players)
    }
    
    func testSelectedPlayers_whenSelectedRowsAreEmpty_isEmpty() {
        XCTAssertTrue(makeSUT().selectedPlayers.isEmpty)
    }
    
    func testDeletePlayer() {
        let storage = Mocks.PlayerStorageHandler(
            storedPlayers: [.demo]
        )
        let sut = makeSUT(storage: storage)
        
        sut.delete(.demo)
        
        XCTAssertTrue(storage.deletePlayerCalled)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        storage: PlayerStorageHandler = Mocks.PlayerStorageHandler(),
        selectedRows: Binding<Set<UUID>> = .constant([]),
        showListView: Binding<Bool> = .constant(false)
    ) -> PlayersListViewModel {
        .init(
            storage: storage,
            selectedRows: selectedRows,
            showListView: showListView
        )
    }
    
}
