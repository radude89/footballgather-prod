//
//  PlayersListViewModelTests.swift
//  PlayersListViewModelTests
//
//  Created by Radu Dan on 05.09.2021.
//

import XCTest
import CoreModels
import SwiftUI
@testable import FootballGather

final class PlayersListViewModelTests: XCTestCase {
    
    override func tearDown() {
        Mocks.storage.clear()
        super.tearDown()
    }
    
    func testHasSelected_whenRowContainsPlayerID_isTrue() {
        let player = Player.demoPlayers[0]
        let selectedRowID = player.id
        let sut = PlayersListViewModel(
            storage: Mocks.storage,
            selectedRows: .constant([selectedRowID])
        )
        
        XCTAssertTrue(sut.hasSelected(player))
    }
    
    func testHasSelected_whenSelectedRowsAreEmpty_isFalse() {
        let sut = PlayersListViewModel(
            storage: Mocks.storage,
            selectedRows: .constant([])
        )
        
        XCTAssertFalse(
            sut.hasSelected(.demoPlayers[0])
        )
    }
    
    func testHasSelected_whenRowDoesNotContainPlayer_isFalse() {
        let selectedRows = Set<UUID>(
            Player.demoPlayers.map { $0.id }
        )
        let sut = PlayersListViewModel(
            storage: Mocks.storage,
            selectedRows: .constant(selectedRows)
        )
        
        XCTAssertFalse(
            sut.hasSelected(Player(name: "John"))
        )
    }
    
    func testHasSelected_whenAllRowsAreSelected_isTrueForAllPlayers() {
        let players = Player.demoPlayers
        players.forEach { Mocks.storage.updatePlayer($0) }
        
        let selectedRows = Set<UUID>(players.map { $0.id })
        let sut = PlayersListViewModel(
            storage: Mocks.storage,
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
        let sut = PlayersListViewModel(
            storage: Mocks.storage,
            selectedRows: .constant([UUID(), UUID()])
        )
        
        XCTAssertTrue(sut.shouldConfirmPlayers)
    }
    
    func testShouldConfirmPlayers_whenSeletedRowsAreGreaterThanTwo_isTrue() {
        let sut = PlayersListViewModel(
            storage: Mocks.storage,
            selectedRows: .constant([UUID(), UUID(), UUID()])
        )
        
        XCTAssertTrue(sut.shouldConfirmPlayers)
    }
    
    func testShouldConfirmPlayers_whenSeletedRowsAreZero_isFalse() {
        let sut = PlayersListViewModel(
            storage: Mocks.storage,
            selectedRows: .constant([])
        )
        
        XCTAssertFalse(sut.shouldConfirmPlayers)
    }
    
    func testShouldConfirmPlayers_whenSeletedRowsAreOne_isFalse() {
        let sut = PlayersListViewModel(
            storage: Mocks.storage,
            selectedRows: .constant([UUID()])
        )
        
        XCTAssertFalse(sut.shouldConfirmPlayers)
    }
    
    func testSelectedPlayers_whenSelectedRowsAreNotEmpty_equalsCorrectPlayers() {
        let players = Player.demoPlayers
        players.forEach { Mocks.storage.updatePlayer($0) }
        let selectedRows = Set<UUID>(players.map { $0.id })
        
        let sut = PlayersListViewModel(
            storage: Mocks.storage,
            selectedRows: .constant(selectedRows)
        )
        
        XCTAssertEqual(sut.selectedPlayers, players)
    }
    
    func testSelectedPlayers_whenSelectedRowsAreEmpty_isEmpty() {
        let sut = PlayersListViewModel(
            storage: Mocks.storage,
            selectedRows: .constant([])
        )
        
        XCTAssertTrue(sut.selectedPlayers.isEmpty)
    }
    
    func testDeletePlayer() {
        let player = Player(name: "John Doe")
        Mocks.storage.updatePlayer(player)
        
        var showListView = false
        let showListViewBinding = Binding<Bool>(
            get: { showListView },
            set: { showListView = $0 }
        )
        
        let sut = PlayersListViewModel(
            storage: Mocks.storage,
            selectedRows: .constant([]),
            showListView: showListViewBinding
        )
        
        sut.delete(player)
        
        XCTAssertTrue(sut.players.isEmpty)
        XCTAssertFalse(sut.showListView)
    }
    
}
