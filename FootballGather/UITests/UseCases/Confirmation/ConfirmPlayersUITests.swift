//
//  ConfirmPlayersUITests.swift
//  UITests
//
//  Created by Radu Dan on 21.10.2021.
//

import XCTest
import Localizable
import CoreModels

final class ConfirmPlayersUITests: UITestCase {
    
    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        
        launchApp(populatingStorage: true)
        presentPlayerListView()
    }
    
    private func presentPlayerListView() {
        XCTAssertTrue(app.otherElements[.playerList].waitToAppear())
    }
    
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
        selectPlayers()
        confirmSelection()
        assertNavigationTitle(is: LocalizedString.confirmPlayersTitle)

        let playersTeamsTable = app.tables[.confirmPlayersView]
        XCTAssertTrue(playersTeamsTable.waitToAppear())
        
        assertSectionExists(
            havingLabel: Team.bench.name.uppercased(),
            inTable: playersTeamsTable
        )
        
        assertSectionExists(
            havingLabel: Team.teamA.name.uppercased(),
            inTable: playersTeamsTable
        )
        
        assertSectionExists(
            havingLabel: Team.teamB.name.uppercased(),
            inTable: playersTeamsTable
        )
        
        assertRow(at: 0, hasLabel: "John")
        assertRow(at: 1, hasLabel: "Jane")
        
        XCTAssertFalse(app.buttons[.startGatherButton].isEnabled)
    }
    
    // MARK: - Helpers
    
    private func selectPlayers() {
        app.buttons[.selectButton].tap()
        cells[0].tap()
        cells[1].tap()
    }
    
    private func confirmSelection() {
        app.buttons[.confirmButton].tap()
    }
    
    private func assertSectionExists(
        havingLabel label: String,
        inTable table: XCUIElement,
        line: UInt = #line
    ) {
        XCTAssertTrue(table.staticTexts[label].exists, line: line)
    }
    
    private func assertRow(
        at index: Int,
        hasLabel label: String,
        line: UInt = #line
    ) {
        XCTAssertTrue(cells[index].staticTexts[label].exists, line: line)
    }
    
}
