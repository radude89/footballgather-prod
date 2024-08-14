//
//  AddPlayerUITests.swift
//  AddPlayerUITests
//
//  Created by Radu Dan on 07.09.2021.
//

import XCTest
import CoreModels

final class AddPlayerUITests: UITestCase, @unchecked Sendable {
    
    private var selectionHandler: PlayerDetailsSelection!
    
    // MARK: - Setup
    
    override func setUp() async throws {
        try await super.setUp()

        selectionHandler = await PlayerDetailsSelection(app: app)
        await launchApp()
        await presentEmptyView()
        await presentAddView()
    }
    
    @MainActor
    private func presentEmptyView() {
        XCTAssertTrue(app.otherElements[.emptyView].waitToAppear())
        XCTAssertTrue(app.buttons[.addButton].waitToAppear())
    }
    
    @MainActor
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
    @MainActor
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
    @MainActor
    func testCreatingPlayer() {
        let name = "Margaret"

        enterName(name)
        selectSkill()
        selectPosition()
        saveDetails()
        
        XCTAssertTrue(app.buttons[name].waitToAppear())
    }
    
    @MainActor
    private func enterName(_ name: String) {
        let nameField = app.textFields[.enterNameTextfield]
        nameField.tap()
        nameField.typeText(name)
        nameField.dismissKeyboard()
    }
    
    @MainActor
    private func selectSkill() {
        selectionHandler.openItemPicker(for: Player.Skill.unknown, rowType: .skill)
        selectionHandler.selectItem(Player.Skill.amateur)
    }
    
    @MainActor
    private func selectPosition() {
        selectionHandler.openItemPicker(for: Player.Position.unknown, rowType: .position)
        selectionHandler.selectItem(Player.Position.winger)
    }
    
    @MainActor
    private func saveDetails() {
        XCTAssertTrue(saveButton.waitToAppear())
        saveButton.tap()
    }
    
}
