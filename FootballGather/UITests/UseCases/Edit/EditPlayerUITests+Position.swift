//
//  EditPlayerUITests.swift
//  UITests
//
//  Created by Radu Dan on 14.10.2021.
//

import XCTest
import CoreModels

extension EditPlayerUITests {
    
    /// **Scenario 1**: Selecting the position of the player when it has NOT a previously selected position
    ///
    /// **GIVEN** I am in the "Player Details" screen
    /// **WHEN** I tap on the row to select the position
    /// **THEN** I am navigated to the screen where I select the player's position
    /// **AND** I can see a list of all positions
    /// **AND** the 'Unknown' position is selected
    ///
    /// **Scenario 2**: No previous selected position
    ///
    /// **GIVEN** I am in the screen where I select the player's position
    /// **AND** my player has NOT a previous selected position
    /// **WHEN** I select a position
    /// **THEN** the "Save" button becomes ENABLED
    func testEditPosition() {
        XCTAssertFalse(saveButton.isEnabled)

        selectionHandler.openItemPicker(for: unknownPosition, rowType: .position)
        
        assertItemIsSelected(unknownPosition)
        assertItemsAreUnselected(knownPositions)
        
        selectionHandler.selectRandomItem(from: knownPositions)
        
        XCTAssertTrue(saveButton.isEnabled)
    }
    
    /// **Scenario 3**: Selecting the position of the player when it has a previously selected position
    ///
    /// **GIVEN** I am in the "Player Details" screen
    /// **AND** I have already a position assigned to my player
    /// **WHEN** I tap on the row to select the position
    /// **THEN** I am able to select a player's position (from another screen or a menu)
    /// **AND** my player's current position is ticked
    ///
    /// **Scenario 4**: Changing current position
    ///
    /// **GIVEN** I am in the menu or screen where I select the player's position
    /// **AND** my player has a previous selected position
    /// **WHEN** I select a different position than my player currently has
    /// **THEN** the "Save" button becomes ENABLED
    ///
    /// **Scenario 5**: Selecting the same position
    ///
    /// **GIVEN** I am in the menu or screen where I select the player's position
    /// **AND** my player has a previous selected position
    /// **WHEN** I select the same position my player has
    /// **THEN** the "Save" button becomes DISABLED
    func testEditPositionWhenHasAlreadyOne() throws {
        let position = setPlayerWithRandomItem(
            from: knownPositions,
            currentItem: unknownPosition,
            rowType: .position
        )

        XCTAssertFalse(saveButton.isEnabled)

        selectionHandler.selectSameItem(item: position, rowType: .position)
        XCTAssertFalse(saveButton.isEnabled)
        
        selectionHandler.openItemPicker(for: position, rowType: .position)
        
        let restOfPositions = Player.Position.allCases.filter { $0 != position }
        selectionHandler.selectRandomItem(from: restOfPositions)
        XCTAssertTrue(saveButton.isEnabled)
    }
}
