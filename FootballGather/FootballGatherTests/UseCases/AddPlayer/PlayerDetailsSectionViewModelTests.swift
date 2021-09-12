//
//  PlayerDetailsSectionViewModelTests.swift
//  PlayerDetailsSectionViewModelTests
//
//  Created by Radu Dan on 12.09.2021.
//

import XCTest
import SwiftUI
@testable import FootballGather

final class PlayerDetailsSectionViewModelTests: XCTestCase {
    
    func testPlayerName() {
        let playerName = "John"
        let binding = Binding<String> {
            ""
        } set: { newValue in
            XCTAssertEqual(newValue, playerName)
        }
        
        let sut = PlayerDetailsSectionViewModel(playerName: binding)
        sut.playerName = playerName
    }
    
}
