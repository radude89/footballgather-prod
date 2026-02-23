//
//  GatherUITests+Timer.swift
//  UITests
//
//  Created by Radu Dan on 16.12.2021.
//

import XCTest
import FoundationTools
import GatherAssets

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
    @MainActor
    func testTimerInteraction() {
        app.swipeUp()
        assertTime(is: "00:03", state: .stopped)
        
        // Scenario 1: Start timer
        actionTimerButton.tap()
        assertTime(is: "00:02", state: .started)
        
        // Scenario 3: Pause timer
        actionTimerButton.tap()
        assertTimerState(is: .paused)
        
        // Scenario 2: Cancel timer
        cancelTimerButton.tap()
        assertTime(is: "00:03", state: .stopped)
        
        // Scenario 4+5: Start timer and let it run to completion
        actionTimerButton.tap()
        assertTimerState(is: .started)
        assertTimeIsUp()
        assertTime(is: "00:03", state: .stopped)
    }
    
    // MARK: - Helpers
    
    @MainActor
    private func assertTimeIsUp(line: UInt = #line) {
        // Wait for timer to reach 00:00
        _ = app.staticTexts["00:00"].waitForExistence(timeout: 5)
        
        let alert = app.alerts[LocalizedString.timeIsUpTitle]
        XCTAssertTrue(
            alert.waitForExistence(timeout: 5),
            "Time is up alert should be displayed",
            line: line
        )
        alert.buttons[LocalizedString.ok].tap()
    }
}
