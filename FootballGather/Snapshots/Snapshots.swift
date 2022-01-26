//
//  Snapshots.swift
//  Snapshots
//
//  Created by Radu Dan on 25.01.2022.
//

import XCTest
import Localizable
import FoundationTools

final class Snapshots: XCTestCase {
    
    // MARK: - Setup
    
    private var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        continueAfterFailure = false
        setupApp()
        app.launch()
    }
    
    private func setupApp() {
        app = XCUIApplication()
        setupLaunchArguments()
        setupSnapshot(app)
    }
    
    private func setupLaunchArguments() {
        app.launchArguments = ["-uitests"]
        app.launchArguments.append(Command.populateStorage.rawValue)
    }
    
    override func tearDownWithError() throws {
        app.terminate()
        try super.tearDownWithError()
    }
    
    // MARK: - Snapshots

    func testSnapshots() throws {
        // Landing screen - player list
        takeSnapshot(named: "01-player-list")
        
        // Add screen
        app.buttons[.addButton].tap()
        takeSnapshot(named: "02-player-add")
        app.buttons[.cancelButton].tap()
        
        selectPlayers()
        
        // Confirmation screen
        movePlayers()
        takeSnapshot(named: "03-confirm")
        
        // Gather screen
        app.buttons[.startGatherButton].tap()
        XCTAssertTrue(app.tables[.gatherPlayersList].waitForExistence(timeout: 1))
        
        setScore()
        takeSnapshot(named: "04-gather")
        endGather()
        
        // History screen
        app.tabBars.buttons[LocalizedString.pastGathers].tap()
        takeSnapshot(named: "05-history")
    }
    
    // MARK: - Helpers
    
    private func takeSnapshot(named name: String) {
        var snapshotName = name
        
        if UITraitCollection.current.userInterfaceStyle == .dark {
            snapshotName.append("-dark")
        }
        
        snapshot(snapshotName)
    }
    
    private func selectPlayers() {
        app.buttons[.selectButton].tap()
        
        let cells = (0 ..< app.cells.count).enumerated().map { app.cells.element(boundBy: $0.offset) }
        cells[0].tap()
        cells[1].tap()
        
        app.buttons[.confirmButton].tap()
    }
    
    private func movePlayers() {
        let confirmTable = app.tables[.confirmPlayersView]
        
        app.buttons["Reorder John"]
            .press(forDuration: 0.3, thenDragTo: confirmTable.staticTexts["TEAM A"])
        app.buttons["Reorder Jane"]
            .press(forDuration: 0.3, thenDragTo: confirmTable.staticTexts["TEAM B"])
    }
    
    private func setScore() {
        let stepperAccessibilityID = AccessibilityID.scoreStepper
        let stepperTeamA = "\(stepperAccessibilityID.rawValue)-Team A"
        let stepperIncrementer = app.steppers[stepperTeamA].buttons["Increment"]
        stepperIncrementer.tap()
        stepperIncrementer.tap()
    }
    
    private func endGather() {
        app.buttons[.endGatherButton].tap()
        let alert = app.alerts[LocalizedString.endGatherConfirmation]
        XCTAssertTrue(alert.waitForExistence(timeout: 1))
        
        alert.buttons[LocalizedString.yes].tap()
    }
    
}

extension XCUIElementQuery {
    subscript(key: AccessibilityID) -> XCUIElement {
        self[key.rawValue]
    }
}
