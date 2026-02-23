//
//  PlayerMover.swift
//  UITests
//
//  Created by Radu Dan on 23.11.2021.
//

import XCTest
import CoreModels
import TeamSelectionAssets

@MainActor
struct PlayerMover {
    
    private let app: XCUIApplication
    private let table: XCUIElement
    
    init(app: XCUIApplication, table: XCUIElement) {
        self.app = app
        self.table = table
    }
    
    func move(_ playerName: String, to team: Team) {
        table.cells.containing(.staticText, identifier: playerName).firstMatch.tap()
        app.buttons["\(AccessibilityID.moveToTeamButton.rawValue)-\(team.name)"].tap()
    }
    
}
