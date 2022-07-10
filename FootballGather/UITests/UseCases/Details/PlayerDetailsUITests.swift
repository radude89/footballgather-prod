//
//  PlayerDetailsUITests.swift
//  UITests
//
//  Created by Radu Dan on 13.10.2021.
//

import XCTest
import CoreModels
import PlayerDetailsAssets

final class PlayerDetailsUITests: UITestCase {
    
    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        launchApp(populatingStorage: true)
    }
    
    /// **Scenario 1: Navigating to details screen**
    ///
    /// **GIVEN** I am in the "Player List" screen
    /// **WHEN** I tap on a player row
    /// **THEN** I see the "Player Details" screen
    ///
    /// **Scenario 2: Viewing player details**
    ///
    /// **GIVEN** I am in the "Player Details" screen
    /// **WHEN** the screen is loaded
    /// **THEN** I see details of the selected player
    ///
    /// **Scenario 3: Missing information**
    /// **GIVEN** I am in the "Player Details" screen
    /// **WHEN** the screen is loaded
    /// **AND** my player has not information on an entry
    /// **THEN** the text placeholder is empty
    ///
    /// **Scenario 4: Back**
    /// **GIVEN** I am in the "Player Details" screen
    /// **WHEN** I tap on "Back" or I swipe from left to right at the left edge of the screen
    /// **THEN** I am navigated back to "Player List" screen
    func testViewPlayerDetails() throws {
        selectFirstPlayer()
        XCTAssertTrue(app.collectionViews[.detailsView].waitToAppear())
        
        let nameField = app.textFields[.enterNameTextfield]
        let name = try XCTUnwrap(nameField.value as? String)
        
        XCTAssertEqual(name, "John")
        
        assertSkillAndPositionHaveDefaultValues()
        
        goBack()
        
        XCTAssertTrue(app.otherElements[.playerList].exists)
    }
    
    private func selectFirstPlayer() {
        cells[0].tap()
    }
    
    private func assertSkillAndPositionHaveDefaultValues(line: UInt = #line) {
        assertValueExists(
            Player.Skill.unknown.rawValue,
            localizedText: LocalizedString.skill,
            line: line
        )
        assertValueExists(
            Player.Position.unknown.rawValue,
            localizedText: LocalizedString.position,
            line: line
        )
    }
    
    private func assertValueExists(_ value: String, localizedText: String, line: UInt = #line) {
        XCTAssertTrue(app.buttons["\(localizedText), \(value.capitalized)"].exists, line: line)
    }
    
}
