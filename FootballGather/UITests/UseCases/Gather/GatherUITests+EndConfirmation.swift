//
//  GatherUITests+EndConfirmation.swift
//  UITests
//
//  Created by Radu Dan on 30.11.2021.
//

import XCTest
import Localizable

extension GatherUITests {
    
    /// **Scenario 3: Ending gather confirmation popup**
    ///
    /// **GIVEN** I am in the "Gather" screen
    /// **WHEN** I tap on "End Gather" button
    /// **THEN** I am asked if I am sure to end the gather
    ///
    /// **Scenario 4: Confirming ending gather**
    ///
    /// **GIVEN** I seeing the "End Gather" confirmation popup
    /// **WHEN** I tap on "OK"
    /// **THEN** the gather ends
    /// **AND** I am redirected back to "Player List" screen
    /// **AND** all players are unselected
    func testEndGather() {
        let endGatherButton = app.buttons[.endGatherButton]
        XCTAssertTrue(endGatherButton.waitToAppear())
        endGatherButton.tap()
        
        let alert = app.alerts[LocalizedString.endGatherConfirmation]
        XCTAssertTrue(alert.waitToAppear())
        
        alert.buttons[LocalizedString.yes].tap()
        
        XCTAssertTrue(app.otherElements[.playerList].waitToAppear())
    }
}
