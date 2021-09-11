//
//  AddPlayerUITests.swift
//  AddPlayerUITests
//
//  Created by Radu Dan on 07.09.2021.
//

import XCTest
import Localizable

final class AddPlayerUITests: UITestCase {
    
    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        presentEmptyView()
    }
    
    private func presentEmptyView() {
        launchApp()
        XCTAssertTrue(app.otherElements[.emptyView].waitToAppear())
        XCTAssertTrue(app.buttons[.addButton].waitToAppear())
    }
    
    // MARK: - Scenarios
    
    /// **Scenario 1: Adding players**
    ///
    /// **GIVE** I am in the "Player List" screen
    /// **WHEN** I tap on the "Add Player" button
    /// **THEN** I am navigated to the "Add Player" screen
    func testViewAddPlayer() {
        app.buttons[.addButton].tap()
        XCTAssertTrue(app.otherElements[.addView].waitToAppear())
    }
    
}
