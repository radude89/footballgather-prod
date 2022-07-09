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
    /// **AND** the 'Unknown' skill is selected
    ///
    /// **Scenario 2**: No previous selected skill
    ///
    /// **GIVEN** I am in the screen where I select the player's skill
    /// **AND** my player has NOT a previous selected skill
    /// **WHEN** I select a skill
    /// **THEN** the "Save" button becomes ENABLED
    func testEditSkill() {
        XCTAssertFalse(saveButton.isEnabled)

        selectionHandler.openItemPicker(for: unknownSkill, rowType: .skill)
        
        assertItemIsSelected(unknownSkill)
        assertItemsAreUnselected(knownSkills)
        
        selectionHandler.selectRandomItem(from: knownSkills)
        
        XCTAssertTrue(saveButton.isEnabled)
    }
    
    /// **Scenario 3**: Selecting the skill of the player when it has a previously selected skill
    ///
    /// **GIVEN** I am in the "Player Details" screen
    /// **AND** I have already a skill assigned to my player
    /// **WHEN** I tap on the row to select the skill
    /// **THEN** I am able to select a player's skill (from another screen or a menu)
    /// **AND** my player's current skill is ticked
    ///
    /// **Scenario 4**: Changing current skill
    ///
    /// **GIVEN** I am in the menu or screen where I select the player's skill
    /// **AND** my player has a previous selected skill
    /// **WHEN** I select a different skill than my player currently has
    /// **THEN** the "Save" button becomes ENABLED
    ///
    /// **Scenario 5**: Selecting the same skill
    ///
    /// **GIVEN** I am in the menu or screen where I select the player's skill
    /// **AND** my player has a previous selected skill
    /// **WHEN** I select the same skill my player has
    /// **THEN** the "Save" button becomes DISABLED
    func testEditSkillWhenHasAlreadyOne() throws {
        let skill = setPlayerWithRandomItem(
            from: knownSkills,
            currentItem: unknownSkill,
            rowType: .skill
        )

        XCTAssertFalse(saveButton.isEnabled)

        selectionHandler.selectSameItem(item: skill, rowType: .skill)
        XCTAssertFalse(saveButton.isEnabled)
        
        selectionHandler.openItemPicker(for: skill, rowType: .skill)
        
        let restOfSkills = Player.Skill.allCases.filter { $0 != skill }
        selectionHandler.selectRandomItem(from: restOfSkills)
        XCTAssertTrue(saveButton.isEnabled)
    }
}
