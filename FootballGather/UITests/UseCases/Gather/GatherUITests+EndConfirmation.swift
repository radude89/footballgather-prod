//
//  GatherUITests+EndConfirmation.swift
//  UITests
//
//  Created by Radu Dan on 30.11.2021.
//

import XCTest
import GatherAssets

extension GatherUITests {
    
    /// **Scenario 3: Ending gather confirmation popup**
    ///
    /// **GIVEN** I am in the "Gather" screen
    /// **WHEN** I tap on "End Gather" button
    /// **THEN** I am asked if I am sure to end the gather
    @MainActor
    func testEndGather() {
        let endGatherButton = app.buttons[.endGatherButton]
        XCTAssertTrue(endGatherButton.waitToAppear())
        endGatherButton.tap()
        
        let alert = app.alerts[LocalizedString.endGatherConfirmation]
        XCTAssertTrue(alert.waitToAppear())
        
        alert.buttons[LocalizedString.yes].tap()
        
        let doesNotExistPredicate = NSPredicate(format: "exists == FALSE")
        expectation(for: doesNotExistPredicate, evaluatedWith: app.collectionViews[.gatherPlayersList], handler: nil)
        waitForExpectations(timeout: 3, handler: nil)
    }
}
