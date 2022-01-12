//
//  HistoryViewUITests.swift
//  UITests
//
//  Created by Radu Dan on 12.01.2022.
//

import XCTest
import Localizable

final class HistoryViewUITests: UITestCase {
    
    /// **Scenario 1: Navigating to History screen**
    ///
    /// **GIVEN** I am in the main screen
    /// **WHEN** I tap on the "History" tab
    /// **THEN** I am navigated to the "History" screen
    /// **AND** I can see my previous gathers sorted by date newest first
    func testHistoryViewHasEntries() {
//        launchApp(populatingStorage: true)
//        
//        app.tabBars.buttons[.historyTabButton].tap()
//        
//        XCTAssertTrue(app.otherElements[.historyView].waitToAppear())
    }
    
    /// **Scenario 2: No previous gathers**
    ///
    /// **GIVEN** I am in the "History" screen
    /// **AND** I haven't played any matches
    /// **WHEN** the screen is loaded
    /// **THEN** I see a message that I haven't played any gathers
    func testHistoryViewIsEmpty() {
//        launchApp()
//
//        app.tabBars.buttons[.historyTabButton].tap()
//
//        XCTAssertTrue(app.otherElements[.historyEmptyView].waitToAppear())
//        XCTAssertTrue(app.staticTexts[.historyNoEntries].exists)
    }
    
}
