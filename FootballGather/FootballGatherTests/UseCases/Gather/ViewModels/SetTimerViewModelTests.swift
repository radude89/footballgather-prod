//
//  SetTimerViewModelTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 22.12.2021.
//

import XCTest
import UITools
import Localizable
import SwiftUI
import Combine
@testable import FootballGather

final class SetTimerViewModelTests: XCTestCase {
    
    // MARK: - Variables
    
    private let minutesComponent = TwoComponentsPickerViewDataSource.Component(
        values: SetTimerViewModel.formattedTime(from: Array(0...90)),
        name: LocalizedString.minutes,
        accessibilityID: .minutesPickerView,
        selectedValue: .constant("00")
    )
    
    private let secondsComponent = TwoComponentsPickerViewDataSource.Component(
        values: SetTimerViewModel.formattedTime(from: Array(1..<60)),
        name: LocalizedString.seconds,
        accessibilityID: .secondsPickerView,
        selectedValue: .constant("01")
    )
    
    // MARK: - Tests
    
    func testFirstComponent_isMinutesComponent() {
        let sut = SetTimerViewModel(
            selectedMinutes: .constant("00"),
            selectedSeconds: .constant("01")
        )
        let dataSource = sut.makeDataSource()
        
        let firstComponent = dataSource.components.first
        XCTAssertEqual(firstComponent.name, minutesComponent.name)
        XCTAssertEqual(firstComponent.values, minutesComponent.values)
        XCTAssertEqual(firstComponent.accessibilityID, minutesComponent.accessibilityID)
        XCTAssertEqual(firstComponent.selectedValue, minutesComponent.selectedValue)
    }
    
    func testSecondComponent_isSecondsComponent() {
        let sut = SetTimerViewModel(
            selectedMinutes: .constant("00"),
            selectedSeconds: .constant("01")
        )
        let dataSource = sut.makeDataSource()
        
        let secondComponent = dataSource.components.second
        XCTAssertEqual(secondComponent.name, secondsComponent.name)
        XCTAssertEqual(secondComponent.values, secondsComponent.values)
        XCTAssertEqual(secondComponent.accessibilityID, secondsComponent.accessibilityID)
        XCTAssertEqual(secondComponent.selectedValue, secondsComponent.selectedValue)
    }
    
    func testShouldEnableDone_whenNoValueIsChanged_isFalse() {
        let sut = SetTimerViewModel()
        XCTAssertFalse(sut.shouldEnableDone)
    }
    
    func testShouldEnableDone_whenMinutesAreChanged_isTrue() {
        var selectedMinutes = "00"
        let minutesBinding = Binding(
            get: { selectedMinutes },
            set: { selectedMinutes = $0 }
        )
        let sut = SetTimerViewModel(selectedMinutes: minutesBinding)
        
        selectedMinutes = "01"
        
        XCTAssertTrue(sut.shouldEnableDone)
    }
    
    func testShouldEnableDone_whenSecondsAreChanged_isTrue() {
        var selectedSeconds = "00"
        let secondsBinding = Binding(
            get: { selectedSeconds },
            set: { selectedSeconds = $0 }
        )
        let sut = SetTimerViewModel(selectedSeconds: secondsBinding)
        
        selectedSeconds = "01"
        
        XCTAssertTrue(sut.shouldEnableDone)
    }
    
}
