//
//  ConfirmPlayersUITests+View.swift
//  UITests
//
//  Created by Radu Dan on 16.11.2021.
//

import XCTest
import CoreModels

extension ConfirmPlayersUITests {
    
    /// **Scenario 1: Navigating to Confirmation screen**
    ///
    /// **GIVEN** I am in the "Player List" screen
    /// **AND** I selected at least two players
    /// **WHEN** I tap on "Confirm Players"
    /// **THEN** I am navigated to the "Confirmation" screen
    /// **AND** the title is "Confirm Players"
    /// **AND** I see three sections "BENCH", "TEAM A" and "TEAM B"
    /// **AND** I see my selected players under the "BENCH" section
    /// **AND** the bottom "Start Gather" button is DISABLED
    func testViewConfirmPlayers() {
        let teamsAsserter = TeamsTableAsserter(cells: cells, table: confirmTable)

        teamsAsserter.assertSection(forTeam: .bench, shouldExist: true)
        teamsAsserter.assertSection(forTeam: .teamA, shouldExist: true)
        teamsAsserter.assertSection(forTeam: .teamB, shouldExist: true)
        
        teamsAsserter.assertRow(at: 0, hasLabel: "John")
        teamsAsserter.assertRow(at: 1, hasLabel: "Jane")
        
        XCTAssertFalse(app.buttons[.startGatherButton].isEnabled)
    }
}
