//
//  PlayersListViewModelTests.swift
//  PlayersListViewModelTests
//
//  Created by Radu Dan on 05.09.2021.
//

import XCTest
import CoreModels
@testable import FootballGather

final class PlayersListViewModelTests: XCTestCase {
    
    func testHasSelected_whenRowContainsPlayerID_isTrue() {
        let player = Player.demoPlayers[0]
        let selectedRowID = player.id
        let sut = PlayersListViewModel(
            players: .demoPlayers,
            selectedRows: .constant([selectedRowID])
        )
        
        XCTAssertTrue(sut.hasSelected(player))
    }
    
    func testHasSelected_whenSelectedRowsAreEmpty_isFalse() {
        let sut = PlayersListViewModel(
            players: .demoPlayers,
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
            players: .demoPlayers,
            selectedRows: .constant(selectedRows)
        )
        
        XCTAssertFalse(
            sut.hasSelected(Player(name: "John"))
        )
    }
    
    func testHasSelected_whenAllRowsAreSelected_isTrueForAllPlayers() {
        let players = Player.demoPlayers
        let selectedRows = Set<UUID>(players.map { $0.id })
        let sut = PlayersListViewModel(
            players: players,
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
    
}
