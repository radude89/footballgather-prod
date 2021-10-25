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
//        selectPlayers()
//        confirmSelection()
//        
//        XCTAssertTrue(app.otherElements[.confirmPlayersView].waitToAppear())
//        
//        let navBar = app.navigationBars.element(boundBy: 0)
//        XCTAssertEqual(navBar.identifier, LocalizedString.confirmPlayersTitle)
//        
//        XCTAssertTrue(app.tables[.confirmPlayersTableView].waitToAppear())
//        
//        XCTAssertTrue(app.tables.otherElements[.benchView].exists)
//        XCTAssertTrue(app.tables.otherElements[.teamAView].exists)
//        XCTAssertTrue(app.tables.otherElements[.teamBView].exists)
//        
//        XCTAssertEqual(cells[0].label, "Jane")
//        XCTAssertEqual(cells[1].label, "John")
//        
//        XCTAssertFalse(app.buttons[.startGatherButton].isEnabled)
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
    
}
