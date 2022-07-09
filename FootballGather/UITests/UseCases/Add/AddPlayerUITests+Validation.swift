//
//  AddPlayerUITests+Validation.swift
//  UITests
//
//  Created by Radu Dan on 26.09.2021.
//

import XCTest

// MARK: - Scenarios for validation

extension AddPlayerUITests {
    
    /// **Scenario 1: Validation**
    ///
    /// **GIVEN** I am in the "Add Player" screen
    /// **WHEN** I enter one character
    /// **THEN** I run a validation function on the entered text**
    ///
    /// **Scenario 2: Empty field**
    ///
    /// **GIVEN** I am in the "Add Player" screen
    /// **WHEN** the field is empty
    /// **THEN** the "Save" button is disabled
    ///
    /// **Scenario 3: Invalid field**
    ///
    /// **GIVEN** I am in the "Add Player" screen
    /// **WHEN** the field is invalid
    /// **THEN** the "Save" button is disabled
    ///
    /// **Scenario 4: Valid field**
    ///
    /// **GIVEN** I am in the "Add Player" screen
    /// **WHEN** the field is valid
    /// **THEN** the "Save" button is enabled
    func testValidation() {
        let nameField = app.textFields[.enterNameTextfield]

        XCTAssertTrue(saveButton.waitToAppear())
        XCTAssertFalse(saveButton.isEnabled)
        
        nameField.tap()
        nameField.typeText("John")
        
        XCTAssertTrue(saveButton.isEnabled)
        
        nameField.clearText()
        
        XCTAssertFalse(saveButton.isEnabled)
        
        nameField.typeText(" Jane")
        XCTAssertFalse(saveButton.isEnabled)
    }
}
