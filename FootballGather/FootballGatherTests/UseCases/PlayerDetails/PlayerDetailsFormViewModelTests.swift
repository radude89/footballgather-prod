//
//  PlayerDetailsFormViewModelTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 21.09.2021.
//

import XCTest
import SwiftUI
import CoreModels
@testable import FootballGather

final class PlayerDetailsFormViewModelTests: XCTestCase {
    
    func testSelectedPlayer() {
        let player = Player(name: "John")
        let binding = Binding<Player> {
            .init(name: "")
        } set: { newValue in
            XCTAssertEqual(newValue, player)
        }
        
        let sut = PlayerDetailsFormViewModel(selectedPlayer: binding)
        sut.selectedPlayer = player
    }
    
}
