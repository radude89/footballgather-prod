//
//  AddPlayerUITests.swift
//  AddPlayerUITests
//
//  Created by Radu Dan on 07.09.2021.
//

import XCTest
import Localizable
import CoreModels

final class AddPlayerUITests: UITestCase {
    
    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        
        launchApp()
        presentEmptyView()
        presentAddView()
    }
    
    private func presentEmptyView() {
        XCTAssertTrue(app.otherElements[.emptyView].waitToAppear())
        XCTAssertTrue(app.buttons[.addButton].waitToAppear())
    }
    
    private func presentAddView() {
        app.buttons[.addButton].tap()
        XCTAssertTrue(app.otherElements[.addView].waitToAppear())
    }
    
    // MARK: - Scenarios for viewing players
    
    /// **Scenario 1: Adding players**
    ///
    /// **GIVEN** I am in the "Player List" screen
    /// **WHEN** I tap on the "Add Player" button
    /// **THEN** I am navigated to the "Add Player" screen
    func testViewAddPlayer() {
        XCTAssertTrue(app.otherElements[.addView].exists)
    }
    
    // MARK: - Scenarios for creating a new player
    
    /// **Scenario 1**: Adding player
    ///
    /// **GIVEN** I am in the "Add Player" screen
    /// **WHEN** I tap on the "Done" button
    /// **THEN** a new player is created
    /// **AND** I am navigated back to the "Player List" screen
    /// **AND** the new player I created is on top of the list
    func testCreatingPlayer() {
        let name = "Margaret"
        let nameField = app.textFields[.enterNameTextfield]
        nameField.tap()
        nameField.typeText(name)
        nameField.dismissKeyboard()
        
        selectRandomSkill()
        selectRandomPosition()
        
        let saveButton = app.buttons[.saveButton]
        XCTAssertTrue(saveButton.waitToAppear())
        saveButton.tap()
        
        XCTAssertTrue(app.cells[name].waitToAppear())
    }
    
}

// MARK: - Helpers
private extension AddPlayerUITests {
    enum CellType {
        case skill
        case position
    }
    
    func selectRandomSkill() {
        selectCell(.skill)
        app.cells.element(boundBy: Int.random(in: 0..<Player.Skill.allCases.count)).tap()
    }
    
    func selectRandomPosition() {
        selectCell(.position)
        app.cells.element(boundBy: Int.random(in: 0..<Player.Position.allCases.count)).tap()
    }
    
    func selectCell(_ type: CellType) {
        let cell: XCUIElement
        
        switch type {
        case .skill:
            cell = app.cells[LocalizedString.skill]
        case .position:
            cell = app.cells[LocalizedString.position]
        }
        
        if !cell.exists {
            app.swipeUp()
        }
        
        cell.tap()
    }
}
