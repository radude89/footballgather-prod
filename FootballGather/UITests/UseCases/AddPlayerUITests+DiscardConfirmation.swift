//
//  AddPlayerUITests+DiscardConfirmation.swift
//  UITests
//
//  Created by Radu Dan on 26.09.2021.
//

import XCTest
import Localizable

// MARK: - Scenarios for discard confirmation alert

extension AddPlayerUITests {
    
    /// **Scenario 1**: Presenting the alert dialog
    ///
    /// **GIVEN** I am in the "Add Player" screen
    /// **AND** I entered at least one valid character
    /// **WHEN** I tap on "Cancel"
    /// **THEN** an alert is presented asking if "Are you sure? Details will be lost."
    ///
    /// **Scenario 2**: Alert dialog confirm exit
    ///
    /// **GIVEN** I am in the "Add Player" screen
    /// **AND** I entered at least one valid character
    /// **AND** I tapped on "Cancel"
    /// **AND** an alert is presented asking if "Are you sure? Details will be lost."
    /// **WHEN** I select "OK"
    /// **THEN** the alert dialog is dismissed
    /// **AND** I am navigated back to the "Player List" screen
    /// **AND** I don't see any new players in the list
    func testDiscard() {
        let nameField = app.textFields[.enterNameTextfield]
        nameField.tap()
        nameField.typeText("A")
        
        tapCancel()
        
        let alert = app.alerts[LocalizedString.discardConfirmation]
        XCTAssertTrue(alert.waitToAppear())
        
        alert.buttons[LocalizedString.discard].tap()
        
        XCTAssertTrue(app.otherElements[.emptyView].exists)
        XCTAssertFalse(app.otherElements[.playerList].exists)
    }
    
    private func tapCancel() {
        let cancelButton = app.buttons[.cancelButton]
        XCTAssertTrue(cancelButton.waitToAppear())
        cancelButton.tap()
    }
    
    /// **Scenario 3**: Alert dialog cancel
    ///
    /// **GIVEN** I am in the "Add Player" screen
    /// **AND** I entered at least one valid character
    /// **AND** I tapped on "Cancel"
    /// **AND** an alert is presented asking if "Are you sure? Details will be lost."
    /// **WHEN** I select "Cancel"
    /// **THEN** the alert dialog dismisses
    /// **AND** I remain in the "Add Player" screen
    func testCancel() {
        let nameField = app.textFields[.enterNameTextfield]
        nameField.tap()
        nameField.typeText("Mike")
        
        tapCancel()
        
        let alert = app.alerts[LocalizedString.discardConfirmation]
        XCTAssertTrue(alert.waitToAppear())
        
        alert.buttons[LocalizedString.cancel].tap()
        
        XCTAssertTrue(app.otherElements[.addView].exists)
    }
}
