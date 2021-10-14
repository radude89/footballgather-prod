//
//  PlayerDetailsUITests.swift
//  UITests
//
//  Created by Radu Dan on 13.10.2021.
//

import XCTest
import CoreModels
import Localizable

final class PlayerDetailsUITests: UITestCase {
    
    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        launchApp(populatingStorage: true)
    }
    
    /// **Scenario 1: Navigating to details screen**
    ///
    /// **GIVEN** I am in the "Player List" screen
    /// **AND** I have not tapped "Select"
    /// **WHEN** I tap on a player row
    /// **THEN** I see the "Player Details" screen
    ///
    /// **Scenario 2: Viewing player details**
    ///
    /// **GIVEN** I am in the "Player Details" screen
    /// **WHEN** the screen is loaded
    /// **THEN** I see details of the selected player
    ///
    /// **Scenario 3: Missing information**
    /// **GIVEN** I am in the "Player Details" screen
    /// **WHEN** the screen is loaded
    /// **AND** my player has not information on an entry
    /// **THEN** the text placeholder is empty
    ///
    /// **Scenario 4: Back**
    /// **GIVEN** I am in the "Player Details" screen
    /// **WHEN** I tap on "Back" or I swipe from left to right at the left edge of the screen
    /// **THEN** I am navigated back to "Player List" screen
    func testViewPlayerDetails() throws {
        cells[0].tap()
        XCTAssertTrue(app.tables[.detailsView].waitToAppear())
        
        let nameField = app.textFields[.enterNameTextfield]
        let name = try XCTUnwrap(nameField.value as? String)
        
        XCTAssertEqual(name, "John")
        
        try assertCellValueIsEmpty(app.cells[LocalizedString.skill])
        try assertCellValueIsEmpty(app.cells[LocalizedString.position])
        
        goBack()
        XCTAssertTrue(app.otherElements[.playerList].exists)
    }
    
    private func assertCellValueIsEmpty(_ cell: XCUIElement, line: UInt = #line) throws {
        let value = try XCTUnwrap(cell.value as? String, line: line)
        XCTAssertTrue(value.isEmpty, line: line)
    }
    
}
