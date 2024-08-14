//
//  HistoryViewUITests.swift
//  UITests
//
//  Created by Radu Dan on 12.01.2022.
//

import XCTest
import HistoryAssets

final class HistoryViewUITests: UITestCase, @unchecked Sendable {
    
    /// **Scenario 1: Navigating to History screen**
    ///
    /// **GIVEN** I am in the main screen
    /// **WHEN** I tap on the "History" tab
    /// **THEN** I am navigated to the "History" screen
    /// **AND** I can see my previous gathers sorted by date newest first
    @MainActor
    func testHistoryViewHasEntries() {
        launchApp(populatingStorage: true)
        
        historyTabButton.tap()
        
        XCTAssertTrue(app.collectionViews[.historyView].waitToAppear())
    }
    
    @MainActor
    private var historyTabButton: XCUIElement {
        app.tabBars.buttons[LocalizedString.pastGathers]
    }
    
    /// **Scenario 2: No previous gathers**
    ///
    /// **GIVEN** I am in the "History" screen
    /// **AND** I haven't played any matches
    /// **WHEN** the screen is loaded
    /// **THEN** I see a message that I haven't played any gathers
    @MainActor
    func testHistoryViewIsEmpty() {
        launchApp()

        historyTabButton.tap()

        XCTAssertTrue(app.staticTexts[.historyNoEntries].exists)
    }
    
}
