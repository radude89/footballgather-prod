//
//  AddPlayerUITests+DiscardConfirmation.swift
//  UITests
//
//  Created by Radu Dan on 26.09.2021.
//

import XCTest
import PlayerDetailsAssets

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
        enterName("A")
        tapCancel()
        tapOnConfirmationAlertButton(named: LocalizedString.discard)
        
        XCTAssertTrue(app.otherElements[.emptyView].exists)
        XCTAssertFalse(app.otherElements[.playerList].exists)
    }
    
    private func enterName(_ name: String) {
        let nameField = app.textFields[.enterNameTextfield]
        nameField.tap()
        nameField.typeText(name)
        nameField.dismissKeyboard()
    }
    
    private func tapCancel() {
        let cancelButton = app.buttons[PlayerDetailsAssets.AccessibilityID.cancelButton]
        XCTAssertTrue(cancelButton.waitToAppear())
        cancelButton.tap()
    }
    
    private func tapOnConfirmationAlertButton(named buttonName: String) {
        let alert = app.alerts[LocalizedString.discardConfirmation]
        XCTAssertTrue(alert.waitToAppear())
        
        alert.buttons[buttonName].tap()
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
        enterName("Mike")
        tapCancel()
        tapOnConfirmationAlertButton(named: LocalizedString.cancel)
        
        XCTAssertTrue(app.otherElements[.addView].exists)
    }
}
