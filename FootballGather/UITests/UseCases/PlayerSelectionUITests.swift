//
//  PlayerSelectionUITests.swift
//  UITests
//
//  Created by Radu Dan on 30.08.2021.
//

import XCTest
import Localizable

final class PlayerSelectionUITests: UITestCase {
    
    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        presentPlayerList()
    }
    
    private func presentPlayerList() {
        launchApp(populatingStorage: true)
        XCTAssertTrue(app.otherElements[.playerList].waitToAppear())
    }
    
    // MARK: - Scenarios
    
    /// **Scenario 1: Selecting players**
    ///
    /// **GIVEN** I am in the "Player List" screen
    /// **WHEN** I tap on "Select"
    /// **THEN** I can see all my players having a checkbox for selection
    /// **AND** I can select a player by tapping on his entry
    ///
    /// **Scenario 2: Selecting one player**
    ///
    /// **GIVEN** I am in the "Player List" screen
    /// **AND** I tapped on the "Select" button
    /// **WHEN** I select one player
    /// **THEN** the checkbox is ticked, marking the player for selection
    ///
    /// **Scenario 3: Unselecting one player**
    ///
    /// **GIVEN** I am in the "Player List" screen
    /// **AND** I tapped on the "Select" button
    /// **AND** I have selected a player having the checkbox ticked
    /// **WHEN** I select the same player again
    /// **THEN** my player becomes unselected
    /// **AND** the checkbox is unticked
    func testSelectingPlayers() {
        app.buttons[.editButton].tap()
        XCTAssertTrue(app.buttons[.doneButton].waitToAppear())
        
        cells.forEach { cell in
            XCTAssertTrue(cell.staticTexts[.unselectedRow].waitToAppear())
            cell.tap()
            XCTAssertTrue(cell.staticTexts[.selectedRow].waitToAppear())
        }
    }
    
    /// **Scenario 4: Number of selected players**
    ///
    /// **GIVEN** I am in the "Player List" screen
    /// **AND** I tapped on the "Select" button
    /// **WHEN** I am done selecting players
    /// **AND** I selected at least one player
    /// **THEN** the title displays the number of selected players
    func testNumberOfSelectedPlayersUpdatesTitle() {
        app.buttons[.editButton].tap()
        XCTAssertTrue(app.buttons[.doneButton].waitToAppear())
        
        let navBar = app.navigationBars.element(boundBy: 0)
        XCTAssertEqual(navBar.identifier, LocalizedString.players)
        
        cells[0].tap()
        cells[1].tap()
        app.buttons[.doneButton].tap()
        
        XCTAssertEqual(navBar.identifier, String(format: LocalizedString.selectedCount, 2))
        
        // unselecting the rows
        app.buttons[.editButton].tap()
        cells[0].tap()
        cells[1].tap()
        app.buttons[.doneButton].tap()
        
        XCTAssertEqual(navBar.identifier, LocalizedString.players)
        
        // tap edit and then done should not select any players
        app.buttons[.editButton].tap()
        app.buttons[.doneButton].tap()
        
        XCTAssertEqual(navBar.identifier, LocalizedString.players)
    }
    
}
