//
//  PlayerListUITests.swift
//  UITests
//
//  Created by Radu Dan on 18.05.2021.
//

import XCTest

final class PlayerListUITests: UITestCase, @unchecked Sendable {
    
    /// **Scenario 1: View list of players**
    ///
    /// **GIVEN** I have created at least one player
    /// **WHEN** I am in the "Player List" screen
    /// **THEN** I can see all my players, ordered by the last date I have created them
    @MainActor
    func testViewPlayerList() {
        launchApp(populatingStorage: true)
        XCTAssertTrue(app.otherElements[.playerList].waitToAppear())
    }
    
    /// **Scenario 2: Information to create players**
    ///
    /// **GIVEN** I haven't created any players
    /// **WHEN** I am in the "Player List" screen
    /// **THEN** I can see a text saying that I don't have any players created
    @MainActor
    func testViewEmptyList() {
        launchApp()
        XCTAssertTrue(app.otherElements[.emptyView].waitToAppear())
    }

}
