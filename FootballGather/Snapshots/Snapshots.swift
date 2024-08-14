//
//  Snapshots.swift
//  Snapshots
//
//  Created by Radu Dan on 25.01.2022.
//

import XCTest
import FoundationTools
import HistoryAssets
import PlayerListAssets
import TeamSelectionAssets
import GatherAssets

final class Snapshots: XCTestCase, @unchecked Sendable {
    
    // MARK: - Setup
    
    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
    }

    override func tearDown() async throws {
        await app.terminate()
        try await super.tearDown()
    }
    
    // MARK: - Snapshots

    @MainActor
    func testSnapshots() throws {
        // Setup and launch the app
        setupApp()
        app.launch()

        // Landing screen - player list
        takeSnapshot(named: "01-player-list")
        
        // Add screen
        app.buttons[.addButton].tap()
        takeSnapshot(named: "02-player-add")
        app.buttons[PlayerListAssets.AccessibilityID.cancelButton.rawValue].tap()
                
        // Confirmation screen
        app.buttons[.confirmButton].tap()
        movePlayers()
        takeSnapshot(named: "03-confirm")
        
        // Gather screen
        app.buttons[.startGatherButton].tap()
        handlePermissionAlert()
        XCTAssertTrue(app.collectionViews[.gatherPlayersList].waitForExistence(timeout: 5))

        setScore()
        takeSnapshot(named: "04-gather")
        endGather()

        // History screen
        app.tabBars.buttons[LocalizedString.pastGathers].tap()
        takeSnapshot(named: "05-history")
    }
    
}

// MARK: - Helpers

@MainActor
private extension Snapshots {
    func setupApp() {
        setupLaunchArguments()
        addUIInterruptionMonitor()
        setupSnapshot(app)
    }
    
    func setupLaunchArguments() {
        app.launchArguments = ["-uitests"]
        app.launchArguments.append(Command.populateStorage.rawValue)
    }

    func takeSnapshot(named name: String) {
        var snapshotName = name
        
        if UITraitCollection.current.userInterfaceStyle == .dark {
            snapshotName.append("-dark")
        }
        
        snapshot(snapshotName)
    }
    
    func movePlayers() {
        let confirmTable = app.tables[.confirmPlayersView]
        
        app.buttons["Reorder John"]
            .press(forDuration: 0.3, thenDragTo: confirmTable.staticTexts["TEAM A"])
        app.buttons["Reorder Jane"]
            .press(forDuration: 0.3, thenDragTo: confirmTable.staticTexts["TEAM B"])
    }
    
    func setScore() {
        let stepperAccessibilityID = AccessibilityID.scoreStepper
        let stepperTeamA = "\(stepperAccessibilityID.rawValue)-Team A"
        let stepperIncrementer = app.steppers[stepperTeamA].buttons["Increment"]
        stepperIncrementer.tap()
        stepperIncrementer.tap()
    }
    
    func endGather() {
        app.buttons[.endGatherButton].tap()
        let alert = app.alerts[LocalizedString.endGatherConfirmation]
        XCTAssertTrue(alert.waitForExistence(timeout: 1))
        
        alert.buttons[LocalizedString.yes].tap()
    }
}

// MARK: - Permissions Alert

@MainActor
private extension Snapshots {
    func addUIInterruptionMonitor() {
        addUIInterruptionMonitor(
            withDescription: "Notification alert"
        ) { [weak self] alert in
            self?.handleAlertPermissions(alert) ?? false
        }
    }
    
    func handleAlertPermissions(_ alert: XCUIElement) -> Bool {
        let notifPermission = "Would Like to Send You Notifications"
        guard alert.labelContains(text: notifPermission) else {
            return false
        }
        
        let allowButton = alert.buttons.element(boundBy: 1)
        if allowButton.exists {
            allowButton.tap()
            return true
        }
        
        return false
    }
    
    func handlePermissionAlert() {
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        
        let allowBtn = springboard.buttons["Allow"]
        if allowBtn.waitForExistence(timeout: 3) {
            allowBtn.tap()
        }
    }
}

// MARK: - Extensions

extension XCUIElementQuery {
    subscript(key: HistoryAssets.AccessibilityID) -> XCUIElement {
        self[key.rawValue]
    }
    
    subscript(key: PlayerListAssets.AccessibilityID) -> XCUIElement {
        self[key.rawValue]
    }
    
    subscript(key: TeamSelectionAssets.AccessibilityID) -> XCUIElement {
        self[key.rawValue]
    }
    
    subscript(key: GatherAssets.AccessibilityID) -> XCUIElement {
        self[key.rawValue]
    }
}
 
extension XCUIElement {
    func labelContains(text: String) -> Bool {
        let predicate = NSPredicate(format: "label CONTAINS %@", text)
        return staticTexts.matching(predicate).firstMatch.exists
    }
}
