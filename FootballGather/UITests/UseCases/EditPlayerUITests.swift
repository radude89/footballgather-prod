//
//  EditPlayerUITests.swift
//  UITests
//
//  Created by Radu Dan on 14.10.2021.
//

import XCTest
import CoreModels

final class EditPlayerUITests: UITestCase {
    
    private var selectionHandler: PlayerDetailsSelection!
    private let playerToEditIndex = 1
    
    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        
        selectionHandler = PlayerDetailsSelection(app: app)
        launchApp(populatingStorage: true)
        presentPlayerDetails()
    }
    
    private func presentPlayerDetails() {
        cells[playerToEditIndex].tap()
        XCTAssertTrue(app.tables[.detailsView].waitToAppear())
    }
    
    /// **Scenario 1**: Selecting the position of the player when it has NOT a previously selected position
    ///
    /// **GIVEN** I am in the "Player Details" screen
    /// **WHEN** I tap on the row to select the position
    /// **THEN** I am navigated to the screen where I select the player's position
    /// **AND** I can see a list of all positions
    /// **AND** I don't see any ticked items
    /// 
    /// **Scenario 2**: No previous selected position
    ///
    /// **GIVEN** I am in the screen where I select the player's position
    /// **AND** my player has NOT a previous selected position
    /// **WHEN** I select a position
    /// **THEN** the "Save" button becomes ENABLED
    func testEditPosition() {
        let saveButton = app.buttons[.saveButton]
        XCTAssertFalse(saveButton.isEnabled)

        selectionHandler.selectCell(.position)
        
        cells.forEach { cell in
            XCTAssertFalse(cell.isTicked)
        }
        
        selectionHandler.selectPosition()
        
        XCTAssertTrue(saveButton.isEnabled)
    }
    
    /// **Scenario 3**: Selecting the position of the player when it has a previously selected position
    ///
    /// **GIVEN** I am in the "Player Details" screen
    /// **AND** I have already a position assigned to my player
    /// **WHEN** I tap on the row to select the position
    /// **THEN** I am navigated to the screen where I select the player's position
    /// **AND** my player's current position is ticked
    ///
    /// **Scenario 4**: Changing current position
    ///
    /// **GIVEN** I am in the screen where I select the player's position
    /// **AND** my player has a previous selected position
    /// **WHEN** I select a different position than my player currently has
    /// **THEN** the "Save" button becomes ENABLED
    ///
    /// **Scenario 5**: Selecting the same position
    ///
    /// **GIVEN** I am in the screen where I select the player's position
    /// **AND** my player has a previous selected position
    /// **WHEN** I select the same position my player has
    /// **THEN** the "Save" button becomes DISABLED
    func testEditPositionWhenHasAlreadyOne() throws {
        updatePlayerWithRandomPosition()
        selectionHandler.selectCell(.position)
        
        let tickedCell = try XCTUnwrap(cells.first { $0.isTicked })
        XCTAssertTrue(tickedCell.exists)
        tickedCell.tap()
        
        goBack()
        
        let saveButton = app.buttons[.saveButton]
        XCTAssertFalse(saveButton.isEnabled)
        
        selectionHandler.selectCell(.position)
        let firstUntickedCell = try XCTUnwrap(cells.first { !$0.isTicked })
        firstUntickedCell.tap()
        
        XCTAssertTrue(saveButton.isEnabled)
    }
    
    private func updatePlayerWithRandomPosition() {
        selectRandomPosition()
        save()
        // last cell contains the edited player
        cells[cells.count - 1].tap()
    }
    
    private func selectRandomPosition() {
        selectionHandler.selectCell(.position)
        selectionHandler.selectPosition()
    }
    
    private func save() {
        let saveButton = app.buttons[.saveButton]
        saveButton.tap()
    }
    
}
