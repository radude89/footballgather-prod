//
//  ConfirmPlayersUITests.swift
//  UITests
//
//  Created by Radu Dan on 21.10.2021.
//

import XCTest
import Localizable

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
            havingID: .benchView,
            label: LocalizedString.benchSection,
            inTable: playersTeamsTable
        )
        
        assertSectionExists(
            havingID: .teamAView,
            label: LocalizedString.teamASection,
            inTable: playersTeamsTable
        )
        
        assertSectionExists(
            havingID: .teamBView,
            label: LocalizedString.teamBSection,
            inTable: playersTeamsTable
        )
        
        assertRow(at: 0, hasLabel: "John")
        assertRow(at: 1, hasLabel: "Jane")
        
        XCTAssertFalse(app.buttons[.startGatherButton].isEnabled)
    }
    
    private func selectPlayers() {
        app.buttons[.selectButton].tap()
        cells[0].tap()
        cells[1].tap()
    }
    
    private func confirmSelection() {
        app.buttons[.confirmButton].tap()
    }
    
    private func assertSectionExists(
        havingID id: AccessibilityID,
        label: String,
        inTable table: XCUIElement,
        line: UInt = #line
    ) {
        XCTAssertTrue(table.staticTexts[id].exists, line: line)
        XCTAssertTrue(table.staticTexts[label].exists, line: line)
    }
    
    private func assertRow(at index: Int, hasLabel label: String, line: UInt = #line) {
        XCTAssertEqual(cells[index].label, label, line: line)
    }
    
}
