//
//  PositionPickerViewModelTests.swift
//  PositionPickerViewModelTests
//
//  Created by Radu Dan on 12.09.2021.
//

import XCTest
import SwiftUI
import CoreModels
@testable import FootballGather

final class PositionPickerViewModelTests: XCTestCase {
    
    private let positions = Player.Position.allCases
    
    func testPositionBinding_whenNotNil() {
        positions.forEach { position in
            let positionBinding = Binding<Player.Position?> {
                nil
            } set: { newValue in
                XCTAssertEqual(newValue, position)
            }
            
            PositionPickerViewModel(position: positionBinding).position = position
        }
    }
    
    func testPositionBinding_whenNil() {
        let sut = PositionPickerViewModel(position: .constant(nil))
        XCTAssertNil(sut.position)
    }
    
    func testAllPositions() {
        let sut = PositionPickerViewModel(position: .constant(nil))
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
