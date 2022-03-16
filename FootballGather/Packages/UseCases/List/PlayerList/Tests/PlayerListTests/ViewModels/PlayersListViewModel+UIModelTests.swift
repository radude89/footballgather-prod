//
//  PlayersListViewModel+UIModelTests.swift
//  PlayersListViewModel+UIModelTests
//
//  Created by Radu Dan on 05.09.2021.
//

import XCTest
import SwiftUI
import CoreModels
import FoundationMocks
@testable import PlayerList

final class PlayersListViewModelUIModelTests: XCTestCase {
    
    private let players = Player.demoPlayers
    
    private var rowIndex: Int {
        Int.random(in: 0 ..< players.count)
    }
    
    override func tearDown() {
        Mocks.storage.clear()
        super.tearDown()
    }
    
    func testAccessibilityID_whenIsEditingAndHasSelectedPlayer_equalsSelectedEditingPlayerAccessibilityID() {
        let player = players[rowIndex]
        let sut = PlayersListViewModel(
            storage: Mocks.storage,
            selectedRows: .constant([player.id])
        )
        
        XCTAssertEqual(
            sut.accessibilityID(for: player, isEditing: true),
            PlayersListRowAccessibility.selectedEditing(player).id
        )
    }
    
    func testAccessibilityID_whenIsEditingAndHasNotSelectedPlayer_equalsUnselectedEditingPlayerAccessibilityID() {
        let player = players[rowIndex]
        let sut = PlayersListViewModel(
            storage: Mocks.storage,
            selectedRows: .constant([])
        )
        
        XCTAssertEqual(
            sut.accessibilityID(for: player, isEditing: true),
            PlayersListRowAccessibility.unselectedEditing(player).id
        )
    }
    
    func testAccessibilityID_whenIsNotEditing_equalsUnselectedPlayerAccessibilityID() {
        let player = players[rowIndex]
        let sut = PlayersListViewModel(
            storage: Mocks.storage,
            selectedRows: .constant([player.id])
        )
        
        XCTAssertEqual(
            sut.accessibilityID(for: player, isEditing: false),
            PlayersListRowAccessibility.unselected(player).id
        )
    }
    
    func testAccessibilityLabel_whenIsEditingAndHasSelectedPlayer_equalsSelectedEditingPlayerAccessibilityLabel() {
        let player = players[rowIndex]
        let sut = PlayersListViewModel(
            storage: Mocks.storage,
            selectedRows: .constant([player.id])
        )
        
        XCTAssertEqual(
            sut.accessibilityLabel(for: player, isEditing: true),
            PlayersListRowAccessibility.selectedEditing(player).label
        )
    }
    
    func testAccessibilityLabel_whenIsEditingAndHasNotSelectedPlayer_equalsUnselectedEditingPlayerAccessibilityLabel() {
        let player = players[rowIndex]
        let sut = PlayersListViewModel(
            storage: Mocks.storage,
            selectedRows: .constant([])
        )
        
        XCTAssertEqual(
            sut.accessibilityLabel(for: player, isEditing: true),
            PlayersListRowAccessibility.unselectedEditing(player).label
        )
    }
    
    func testAccessibilityLabel_whenIsNotEditing_equalsUnselectedPlayerAccessibilityLabel() {
        let player = players[rowIndex]
        let sut = PlayersListViewModel(
            storage: Mocks.storage,
            selectedRows: .constant([player.id])
        )
        
        XCTAssertEqual(
            sut.accessibilityLabel(for: player, isEditing: false),
            PlayersListRowAccessibility.unselected(player).label
        )
    }
    
}
