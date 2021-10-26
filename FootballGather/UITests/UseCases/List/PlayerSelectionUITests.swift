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
        
        launchApp(populatingStorage: true)
        presentPlayerListView()
    }
    
    private func presentPlayerListView() {
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
        app.buttons[.selectButton].tap()
        XCTAssertTrue(app.buttons[.cancelButton].waitToAppear())
        
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
    /// **WHEN** I selected at least one player
    /// **THEN** the title displays the number of selected players
    func testNumberOfSelectedPlayersUpdatesTitle() {
        app.buttons[.selectButton].tap()
        XCTAssertTrue(app.buttons[.cancelButton].waitToAppear())
        
        XCTAssertFalse(app.buttons[.confirmButton].isEnabled)
        
        assertNavBarTitle(is: LocalizedString.players)
        tapCells(havingIndexes: 0, 1)
        
        assertNavBarTitle(is: String(format: LocalizedString.selectedCount, 2))
        
        XCTAssertTrue(app.buttons[.confirmButton].isEnabled)
        
        // unselecting the rows
        tapCells(havingIndexes: 0, 1)
        app.buttons[.cancelButton].tap()
        
        assertNavBarTitle(is: LocalizedString.players)
        
        // tap edit and then done should not select any players
        app.buttons[.selectButton].tap()
        app.buttons[.cancelButton].tap()
        
        assertNavBarTitle(is: LocalizedString.players)
    }
    
    private var navBar: XCUIElement {
        app.navigationBars.element(boundBy: 0)
    }
    
    private func assertNavBarTitle(is title: String) {
        XCTAssertEqual(navBar.identifier, title)
    }
    
    private func tapCells(havingIndexes indexes: Int...) {
        indexes.forEach { index in
            cells[index].tap()
        }
    }
    
}
