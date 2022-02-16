//
//  TwoComponentsPickerViewDataSourceTests.swift
//  
//
//  Created by Radu Dan on 21.12.2021.
//

import XCTest
import Localizable
@testable import UITools

final class TwoComponentsPickerViewDataSourceTests: XCTestCase {
    
    private let firstComponent = TwoComponentsPickerViewDataSource.Component(
        values: (0...60).map { "\($0)"},
        name: "First Component",
        accessibilityID: .minutesPickerView,
        selectedValue: .constant("0")
    )
    
    private let secondComponent = TwoComponentsPickerViewDataSource.Component(
        values: (0...60).map { "\($0)"},
        name: "Second Component",
        accessibilityID: .secondsPickerView,
        selectedValue: .constant("1")
    )
    
    func testInit() {
        let sut = TwoComponentsPickerViewDataSource(
            (first: firstComponent, second: secondComponent)
        )
        
        XCTAssertEqual(sut.components.first, firstComponent)
        XCTAssertEqual(sut.components.second, secondComponent)
    }
    
}
