//
//  NameDetailsSectionViewModelTests.swift
//  NameDetailsSectionViewModelTests
//
//  Created by Radu Dan on 12.09.2021.
//

import XCTest
import SwiftUI
@testable import PlayerDetails

@MainActor
final class NameDetailsSectionViewModelTests: XCTestCase {
    
    func testPlayerName() {
        let playerName = "John"
        let binding = Binding<String> {
            ""
        } set: { newValue in
            XCTAssertEqual(newValue, playerName)
        }
        
        let sut = NameDetailsSectionViewModel(
            playerName: binding,
            isAddingPlayer: true
        )
        sut.playerName = playerName
    }
    
}
