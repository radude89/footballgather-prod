//
//  PlayerListRowAccessibilityTests.swift
//  PlayerListRowAccessibilityTests
//
//  Created by Radu Dan on 02.09.2021.
//

import XCTest
import SwiftUI
import CoreModels
import Localizable
@testable import FootballGather

final class PlayersListRowAccessibilityTests: XCTestCase {
    
    private let player = Player(name: "John")
    
    func testSelectedEditingPlayer() {
        let sut = PlayersListRowAccessibility.selectedEditing(player)
        
        XCTAssertEqual(
            sut,
            PlayersListRowAccessibility(
                label: Text(
                    String(format: LocalizedString.selectedPlayer, "\(player.name)")
                ),
                id: .selectedRow
            )
        )
    }
    
    func testUnselectedEditingPlayer() {
        let sut = PlayersListRowAccessibility.unselectedEditing(player)
        
        XCTAssertEqual(
            sut,
            PlayersListRowAccessibility(
                label: Text(
                    String(format: LocalizedString.tapToSelectPlayer, "\(player.name)")
                ),
                id: .unselectedRow
            )
        )
    }
    
    func testUnselectedPlayer() {
        let sut = PlayersListRowAccessibility.unselected(player)
        
        XCTAssertEqual(
            sut,
            PlayersListRowAccessibility(
                label: Text(String(player.name)),
                id: .unselectedRow
            )
        )
    }
    
}
