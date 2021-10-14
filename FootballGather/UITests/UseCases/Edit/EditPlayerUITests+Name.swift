//
//  EditPlayerUITests+Name.swift
//  UITests
//
//  Created by Radu Dan on 14.10.2021.
//

import XCTest

extension EditPlayerUITests {
    
    /// **Scenario 1: Selecting the name field**
    ///
    /// **GIVEN** I am in the "Player Details" screen
    /// **WHEN** I tap on a text type details entry
    /// **THEN** the input has focus
    ///
    /// **Scenario 2: Entering a valid name**
    ///
    /// **GIVEN** I am in the "Player Details" screen
    /// **AND** the name field is in focus
    /// **WHEN** I enter a different valid name
    /// **THEN** the "Save" button is ENABLED
    ///
    /// **Scenario 3: Entering the same name**
    ///
    /// **GIVEN** I am in the "Player Details" screen
    /// **AND** the name field is in focus
    /// **WHEN** I enter the same name
    /// **THEN** the "Save" button is DISABLED
    func testEditName() {
        let nameField = app.textFields[.enterNameTextfield]
        let saveButton = app.buttons[.saveButton]

        XCTAssertTrue(saveButton.waitToAppear())
        XCTAssertFalse(saveButton.isEnabled)
        
        nameField.tap()
        nameField.clearText()
        nameField.typeText("Jane")
        XCTAssertFalse(saveButton.isEnabled)
        
        nameField.clearText()
        nameField.typeText(" ")
        XCTAssertFalse(saveButton.isEnabled)
        
        nameField.clearText()
        nameField.typeText("Jane2")
        XCTAssertTrue(saveButton.isEnabled)
    }
    
}
