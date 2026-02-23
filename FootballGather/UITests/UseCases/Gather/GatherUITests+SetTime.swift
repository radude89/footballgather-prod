//
//  GatherUITests+SetTime.swift
//  UITests
//
//  Created by Radu Dan on 21.12.2021.
//

import XCTest

@MainActor
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
    func testSetTime() {
        assertTime(is: "00:03")
        
        setTimeButton.tap()
        
        assertSetTimeViewIsVisible()
        assertPickerComponentsExist()
        assertSelectedPickerTime(is: "00:03")

        minutesPickerView.scroll(toPickerWheelValue: "01")
        wait() // It crashes if interacts right after
        secondsPickerView.scroll(toPickerWheelValue: "02")
        
        cancelTimerButton.firstMatch.tap()
        
        assertTime(is: "00:03")
        
        setTimeButton.tap()
        
        assertSelectedPickerTime(is: "00:03")
        
        minutesPickerView.scroll(toPickerWheelValue: "01")
        wait() // It crashes if interacts right after
        secondsPickerView.scroll(toPickerWheelValue: "02")
        
        doneButton.tap()
        
        assertTime(is: "01:02")
    }
    
    private func assertTime(is time: String, line: UInt = #line) {
        assertTime(is: time, state: .stopped, line: line)
    }
    
    private var setTimeButton: XCUIElement {
        app.buttons[.setTimeButton]
    }
    
    private func assertSetTimeViewIsVisible(line: UInt = #line) {
        XCTAssertTrue(app.otherElements[.setTimeView].waitToAppear(), line: line)
    }
    
    private func assertPickerComponentsExist(line: UInt = #line) {
        XCTAssertTrue(minutesPickerView.exists, line: line)
        XCTAssertTrue(secondsPickerView.exists, line: line)
    }
    
    private var minutesPickerView: XCUIElement {
        app.pickers[.minutesPickerView]
    }
    
    private var secondsPickerView: XCUIElement {
        app.pickers[.secondsPickerView]
    }
    
    private func assertSelectedPickerTime(is value: String, line: UInt = #line) {
        let time = value.components(separatedBy: ":")

        XCTAssertEqual(minutesPickerView.pickerValue, time[0], line: line)
        XCTAssertEqual(secondsPickerView.pickerValue, time[1], line: line)
    }

    private var doneButton: XCUIElement {
        app.buttons[.doneButton]
    }
    
}
