//
//  SaveSectionViewModelTests.swift
//  SaveSectionViewModelTests
//
//  Created by Radu Dan on 12.09.2021.
//

import XCTest
import SwiftUI
@testable import FootballGather

final class SaveSectionViewModelTests: XCTestCase {
    
    func testPlayerName() {
        let playerName = "John"
        let binding = Binding<String> {
            ""
        } set: { newValue in
            XCTAssertEqual(newValue, playerName)
        }
        
        let sut = SaveSectionViewModel(playerName: binding)
        sut.playerName = playerName
    }
    
}
