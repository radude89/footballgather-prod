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
        
        assertBenchSectionExists(in: playersTeamsTable)
        assertTeamASectionExists(in: playersTeamsTable)
        assertTeamBSectionExists(in: playersTeamsTable)
        
        assertRow(at: 0, hasLabel: "John")
        assertRow(at: 1, hasLabel: "Jane")
        
        XCTAssertFalse(app.buttons[.startGatherButton].isEnabled)
    }
    
    private func selectPlayers() {
        app.buttons[.selectButton].tap()
        XCTAssertTrue(app.buttons[.doneButton].waitToAppear())
        
        cells[0].tap()
        cells[1].tap()
        
        app.buttons[.doneButton].tap()
    }
    
    private func confirmSelection() {
        app.buttons[.confirmButton].tap()
    }
    
    private func assertNavigationTitle(is title: String, line: UInt = #line) {
        let navBar = app.navigationBars.element(boundBy: 0)
        XCTAssertEqual(navBar.identifier, title, line: line)
    }
    
    private func assertBenchSectionExists(in table: XCUIElement, line: UInt = #line) {
        XCTAssertTrue(table.staticTexts[.benchView].exists, line: line)
        XCTAssertTrue(table.staticTexts[LocalizedString.benchSection].exists, line: line)
    }
    
    private func assertTeamASectionExists(in table: XCUIElement, line: UInt = #line) {
        XCTAssertTrue(table.staticTexts[.teamAView].exists, line: line)
        XCTAssertTrue(table.staticTexts[LocalizedString.teamASection].exists, line: line)
    }
    
    private func assertTeamBSectionExists(in table: XCUIElement, line: UInt = #line) {
        XCTAssertTrue(table.staticTexts[.teamBView].exists, line: line)
        XCTAssertTrue(table.staticTexts[LocalizedString.teamBSection].exists, line: line)
    }
    
    private func assertRow(at index: Int, hasLabel label: String, line: UInt = #line) {
        XCTAssertEqual(cells[index].label, label, line: line)
    }
    
}
