//
//  GatherUITests+SetTime.swift
//  UITests
//
//  Created by Radu Dan on 21.12.2021.
//

import XCTest
import Localizable

extension GatherUITests {
    
    /// **Scenario 1: Default gather time**
    ///
    /// **GIVEN** I am navigated to "Gather" screen
    /// **WHEN** the screen is loaded
    /// **THEN** the time of the match is set to the initial time
    ///
    /// **Scenario 2: Showing time picker**
    ///
    /// **GIVEN** I am in the "Gather" screen
    /// **WHEN** I tap on "Set"
    /// **THEN** I am presented a time picker with the current selected time
    ///
    /// **Scenario 3: Dismissing picker**
    ///
    /// **GIVEN** I am seeing the time picker
    /// **WHEN** I tap on "Cancel"
    /// **THEN** the time picker is dismissed
    /// **AND** the time changes are discarded
    ///
    /// **Scenario 4: Saving time selection**
    ///
    /// **GIVEN** I am seeing the time picker
    /// **WHEN** I tap on "Save"
    /// **THEN** the time picker is dismissed
    /// **AND** the time changes are updated
    ///
    ///**Scenario 5: Maximum time**
    ///
    /// **GIVEN** I am seeing the time picker
    /// **WHEN** I am scrolling to pick seconds or minutes
    /// **THEN** the maximum value I can choose is "60"
    ///
    /// **Scenario 6: Minimum seconds**
    /// 
    /// **GIVEN** I am seeing the time picker
    /// **WHEN** I am scrolling to pick seconds
    /// **THEN** the minimum value I can choose is "1"
    func testSetTime() {
//        assertTime(is: "00:02")
//        
//        let setTimeButton = app.buttons[.setTimeButton]
//        setTimeButton.tap()
//        
//        XCTAssertTrue(app.otherElements[.setTimeView].waitToAppear())
//        
//        let minutesPickerView = app.pickers[.minutesPickerView]
//        XCTAssertTrue(minutesPickerView.exists)
//        // TODO: Check the picker selected value is `00`
//        
//        let secondsPickerView = app.pickers[.secondsPickerView]
//        XCTAssertTrue(secondsPickerView.exists)
//        // TODO: Check the picker selected value is `02`
//        
//        minutesPickerView.adjust(toPickerWheelValue: "10")
////        minutesPickerView.pickerWheels.element.adjust(toPickerWheelValue: "10")
//        secondsPickerView.adjust(toPickerWheelValue: "20")
//        
//        let cancelSetTimeView = app.buttons[.cancelButton]
//        cancelSetTimeView.tap()
//        
//        assertTime(is: "00:02")
//        
//        setTimeButton.tap()
//        
//        // TODO: Check the picker selected value is `00`
//        // TODO: Check the picker selected value is `02`
//        
//        minutesPickerView.adjust(toPickerWheelValue: "10")
//        secondsPickerView.adjust(toPickerWheelValue: "20")
//        
//        let saveTimeViewButton = app.buttons[.saveButton]
//        saveTimeViewButton.tap()
//        
//        assertTime(is: "10:20")
    }
    
    private func assertTime(is time: String, line: UInt = #line) {
        assertTime(is: time, state: .stopped, line: line)
    }
    
}
