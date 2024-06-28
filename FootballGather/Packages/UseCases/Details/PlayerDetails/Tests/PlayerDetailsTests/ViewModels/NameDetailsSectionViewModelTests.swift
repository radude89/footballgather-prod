//
//  NameDetailsSectionViewModelTests.swift
//  NameDetailsSectionViewModelTests
//
//  Created by Radu Dan on 12.09.2021.
//

import XCTest
import SwiftUI
@testable import PlayerDetails

final class NameDetailsSectionViewModelTests: XCTestCase {
    
    @MainActor
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
