//
//  PlayerListUITests.swift
//  UITests
//
//  Created by Radu Dan on 18.05.2021.
//

import XCTest

final class PlayerListUITests: UITestCase {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        launchApp()
    }
    
    /// **Scenario 1: View list of players**
    ///
    /// **GIVEN** I have created at least one player
    /// **WHEN** I am in the "Player List" screen
    /// **THEN** I can see all my players, ordered by the last date I have created them
    func testViewPlayerList() {
        XCTAssertTrue(app.staticTexts[.playerList].waitToAppear())
        
        
    }

}
