//
//  EditPlayerUITests+Save.swift
//  UITests
//
//  Created by Radu Dan on 14.10.2021.
//

import XCTest

extension EditPlayerUITests {
    
    /// **Scenario 1: Saving details**
    ///
    /// **GIVEN** I am in the "Player Details" screen
    /// **AND** I have changed the players details
    /// **WHEN** I tap on "Save"
    /// **THEN** the changes are committed
    /// **AND** I am returned to the "Player List" screen
    /// **AND** the modified details are reflected in the player's entry
    @MainActor
    func testSaveName() {
        let nameField = app.textFields[.enterNameTextfield]
        let newName = "Jonathan"
        
        nameField.tap()
        nameField.clearText()
        nameField.typeText(newName)
        
        saveButton.tap()
        
        XCTAssertTrue(app.buttons[newName].exists)
    }
    
    /// **Scenario 2: Back**
    ///
    /// **GIVEN** I am in the "Player Details" screen
    /// **WHEN** I tap on "Back" or I swipe from left to right at the left edge of the screen
    /// **THEN** all changes are discarded
    /// **AND** I am navigated back to "Player Details" screen
    @MainActor
    func testBackDiscardsChanges() {
        let nameField = app.textFields[.enterNameTextfield]
        let newName = "Joe"
        
        nameField.tap()
        nameField.clearText()
        nameField.typeText(newName)
        
        goBack()
        
        XCTAssertFalse(app.buttons[newName].exists)
        XCTAssertTrue(app.buttons["Jane"].exists)
    }
    
}
