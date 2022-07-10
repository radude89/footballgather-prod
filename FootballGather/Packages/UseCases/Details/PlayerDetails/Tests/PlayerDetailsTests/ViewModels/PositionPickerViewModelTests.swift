//
//  PositionPickerViewModelTests.swift
//  PositionPickerViewModelTests
//
//  Created by Radu Dan on 12.09.2021.
//

import XCTest
import SwiftUI
import CoreModels
@testable import PlayerDetails

final class PositionPickerViewModelTests: XCTestCase {
    
    private let positions = Player.Position.allCases
    
    func testPositionBinding() {
        positions.forEach { position in
            let positionBinding = Binding<Player.Position> {
                .unknown
            } set: { newValue in
                XCTAssertEqual(newValue, position)
            }
            
            PositionPickerViewModel(position: positionBinding).position = position
        }
    }
    
    func testAllPositions() {
        let sut = PositionPickerViewModel(position: .constant(.unknown))
        XCTAssertEqual(sut.allPositions, positions)
    }
    
    func testPositionRowDescription_capitalizesValue() {
        positions.forEach { position in
            XCTAssertEqual(
                PositionPickerViewModel.positionRowDescription(position),
                position.rawValue.capitalized
            )
        }
    }
    
}
