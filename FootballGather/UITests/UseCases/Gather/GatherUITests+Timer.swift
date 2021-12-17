//
//  GatherUITests+Timer.swift
//  UITests
//
//  Created by Radu Dan on 16.12.2021.
//

import XCTest
import Localizable
import FoundationTools

extension GatherUITests {
    
    /// **Scenario 1: Starting time**
    ///
    /// **GIVEN** I am in the "Gather" screen
    /// **WHEN** I tap on "Start"
    /// **THEN** the timer starts
    /// **AND** the "Start" button's title changes to "Pause"
    ///
    /// **Scenario 2: Cancelling time**
    ///
    /// **GIVEN** I am in the "Gather" screen
    /// **WHEN** I tap on "Cancel"
    /// **THEN** the timer resets to the initial time
    /// **AND** the right button's title is "Start"
    ///
    /// **Scenario 3: Pausing time**
    ///
    /// ** GIVEN** I am in the "Gather" screen
    /// **AND** the timer is started
    /// **WHEN** I tap on "Pause"
    /// **THEN** the timer pauses
    /// **AND** the "Pause" button's title to "Resume"
    ///
    /// **Scenario 4: Resuming time**
    ///
    /// **GIVEN** I am in the "Gather" screen
    /// **AND** the timer is paused
    /// **WHEN** I tap on "Resume"
    /// **THEN** the timer resumes
    /// **AND** the "Resume" button's title changes to "Pause"
    ///
    /// **Scenario 5: Completing time**
    ///
    /// **GIVEN** I am in the "Gather" screen
    /// **AND** the timer is started
    /// **WHEN** the timer reaches "00:00"
    /// **THEN** the timer resets to the initial time
    /// **AND** the right button's title is "Start"
    /// **AND** a popup dialog informing the time is up
    func testTimerInteraction() {
        assertTime(is: "00:02", state: .stopped)
        
        actionTimerButton.tap()
        
        assertTime(is: "00:01", state: .started)
        
        actionTimerButton.tap()
        
        assertTimerState(is: .paused)
        
        actionTimerButton.tap()
        
        assertTimeIsUp()
        
        assertTime(is: "00:02", state: .stopped)
        
        actionTimerButton.tap()
        
        assertTime(is: "00:01", state: .started)
        
        cancelTimerButton.tap()
        
        assertTime(is: "00:02", state: .stopped)
    }
    
    // MARK: - Helpers
    
    private var cancelTimerButton: XCUIElement {
        app.buttons[.cancelButton]
    }
    
    private var actionTimerButton: XCUIElement {
        app.buttons[.actionTimerButton]
    }
    
    private func assertTime(
        is formattedTime: String,
        state: TimerState,
        line: UInt = #line
    ) {
        XCTAssertTrue(app.staticTexts[formattedTime].waitToAppear(), line: line)
        assertTimerState(is: state, line: line)
    }
    
    private func assertTimerState(is state: TimerState, line: UInt = #line) {
        switch state {
        case .started:
            assertActionTimberButtonTitle(
                is: LocalizedString.pauseTimerLabel,
                line: line
            )
        case .paused:
            assertActionTimberButtonTitle(
                is: LocalizedString.resumeTimerLabel,
                line: line
            )
        case .stopped:
            assertActionTimberButtonTitle(
                is: LocalizedString.startTimerLabel,
                isEnabled: false,
                line: line
            )
        }
    }
    
    private func assertActionTimberButtonTitle(
        is title: String,
        isEnabled: Bool = true,
        line: UInt = #line
    ) {
        XCTAssertEqual(actionTimerButton.label, title, line: line)
        XCTAssertEqual(cancelTimerButton.isEnabled, isEnabled, line: line)
    }
    
    private func assertTimeIsUp(line: UInt = #line) {
        let alert = app.alerts[LocalizedString.timeIsUpTitle]
        XCTAssertTrue(alert.waitToAppear(), line: line)
        
        alert.buttons[LocalizedString.ok].tap()
    }
}
