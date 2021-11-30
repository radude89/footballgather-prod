//
//  GatherUITests+View.swift
//  UITests
//
//  Created by Radu Dan on 23.11.2021.
//

import XCTest

extension GatherUITests {
    
    /// **Scenario 1: Showing gather**
    ///
    /// **GIVEN** I am in the "Confirmation" screen
    /// **WHEN** I tap on "Start Gather" button
    /// **THEN** I am navigated to the "Gather" screen
    ///
    /// **Scenario 2: List of players**
    ///
    /// **GIVEN** I am navigated to the "Gather" screen
    /// **WHEN** the screen loads
    /// **THEN** I can see my players I chose in the "Confirmation" screen
    /// **AND** the players are in the correct Team
    func testViewGather() {
        let teamsTable = app.tables[.gatherPlayersList]
        XCTAssertTrue(teamsTable.exists)
        
        let teamsTableAsserter = TeamsTableAsserter(cells: cells, table: teamsTable)
        
        teamsTableAsserter.assertSection(forTeam: .bench, shouldExist: false)
        teamsTableAsserter.assertSection(forTeam: .teamA, shouldExist: true)
        teamsTableAsserter.assertSection(forTeam: .teamB, shouldExist: true)
        
        teamsTableAsserter.assertRow(at: 0, hasLabel: "John")
        teamsTableAsserter.assertRow(at: 1, hasLabel: "Jane")
    }
}
