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

final class PlayerListRowAccessibilityTests: XCTestCase {
    
    private let player = Player(name: "John")
    
    func testSelectedEditingPlayer() {
        let sut = PlayerListRowAccessibility.selectedEditing(player)
        
        XCTAssertEqual(
            sut,
            PlayerListRowAccessibility(
                label: Text(
                    String(format: LocalizedString.selectedPlayer, "\(player.name)")
                ),
                id: .selectedRow
            )
        )
    }
    
    func testUnselectedEditingPlayer() {
        let sut = PlayerListRowAccessibility.unselectedEditing(player)
        
        XCTAssertEqual(
            sut,
            PlayerListRowAccessibility(
                label: Text(
                    String(format: LocalizedString.tapToSelectPlayer, "\(player.name)")
                ),
                id: .unselectedRow
            )
        )
    }
    
    func testUnselectedPlayer() {
        let sut = PlayerListRowAccessibility.unselected(player)
        
        XCTAssertEqual(
            sut,
            PlayerListRowAccessibility(
                label: Text(String(player.name)),
                id: .unselectedRow
            )
        )
    }
    
}
