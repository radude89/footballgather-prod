//
//  PlayerSelectionUITests.swift
//  UITests
//
//  Created by Radu Dan on 30.08.2021.
//

import XCTest

final class PlayerSelectionUITests: UITestCase {
    
    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        presentPlayerList()
    }
    
    private func presentPlayerList() {
        launchApp(populatingStorage: true)
        XCTAssertTrue(app.otherElements[.playerList].waitToAppear())
    }
    
    // MARK: - Scenarios
    
    /// **Scenario 1: Selecting players**
    ///
    /// **GIVEN** I am in the "Player List" screen
    /// **WHEN** I tap on "Select"
    /// **THEN** I can see all my players having a checkbox for selection
    /// **AND** I can select a player by tapping on his entry
    func testSelectingPlayers() {
        app.buttons[.editButton].tap()
        XCTAssertTrue(app.buttons[.doneButton].waitToAppear())
        
        cells.forEach { cell in
            XCTAssertTrue(cell.staticTexts[.unselectedRow].waitToAppear())
            cell.tap()
            XCTAssertTrue(cell.staticTexts[.selectedRow].waitToAppear())
        }
    }
    
}
