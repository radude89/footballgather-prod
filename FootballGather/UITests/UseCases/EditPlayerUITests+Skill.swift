//
//  EditPlayerUITests+Skill.swift
//  UITests
//
//  Created by Radu Dan on 14.10.2021.
//

import XCTest
import CoreModels

extension EditPlayerUITests {
    
    /// **Scenario 1**: Selecting the skill of the player when it has NOT a previously selected a skill
    ///
    /// **GIVEN** I am in the "Player Details" screen
    /// **WHEN** I tap on the row to select the skill
    /// **THEN** I am navigated to the screen where I select the player's skill
    /// **AND** I can see a list of all skills
    /// **AND** I don't see any ticked items
    ///
    /// **Scenario 2**: No previous selected skill
    ///
    /// **GIVEN** I am in the screen where I select the player's skill
    /// **AND** my player has NOT a previous selected skill
    /// **WHEN** I select a skill
    /// **THEN** the "Save" button becomes ENABLED
    func testEditSkill() {
        let saveButton = app.buttons[.saveButton]
        XCTAssertFalse(saveButton.isEnabled)

        selectionHandler.selectCell(.skill)
        assertAllCellsAreUnticked()
        selectionHandler.selectSkill()
        
        XCTAssertTrue(saveButton.isEnabled)
    }
    
    /// **Scenario 3**: Selecting the skill of the player when it has a previously selected skill
    ///
    /// **GIVEN** I am in the "Player Details" screen
    /// **AND** I have already a skill assigned to my player
    /// **WHEN** I tap on the row to select the skill
    /// **THEN** I am navigated to the screen where I select the player's skill
    /// **AND** my player's current skill is ticked
    ///
    /// **Scenario 4**: Changing current skill
    ///
    /// **GIVEN** I am in the screen where I select the player's skill
    /// **AND** my player has a previous selected skill
    /// **WHEN** I select a different skill than my player currently has
    /// **THEN** the "Save" button becomes ENABLED
    ///
    /// **Scenario 5**: Selecting the same skill
    ///
    /// **GIVEN** I am in the screen where I select the player's skill
    /// **AND** my player has a previous selected skill
    /// **WHEN** I select the same skill my player has
    /// **THEN** the "Save" button becomes DISABLED
    func testEditSkillWhenHasAlreadyOne() throws {
        updatePlayerWithRandomSkill()
        selectionHandler.selectCell(.skill)
        try assertHasSelectedOption()
        goBack()
        
        let saveButton = app.buttons[.saveButton]
        XCTAssertFalse(saveButton.isEnabled)
        
        try selectDifferentOption(for: .skill)
        
        XCTAssertTrue(saveButton.isEnabled)
    }
    
    private func updatePlayerWithRandomSkill() {
        selectRandomSkill()
        save()
        // last cell contains the edited player
        cells[cells.count - 1].tap()
    }
    
    private func selectRandomSkill() {
        selectionHandler.selectCell(.skill)
        selectionHandler.selectSkill()
    }
    
}
