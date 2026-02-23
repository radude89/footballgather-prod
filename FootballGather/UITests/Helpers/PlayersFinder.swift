//
//  PlayersFinder.swift
//  UITests
//
//  Created by Radu Dan on 15.11.2021.
//

import XCTest
import CoreModels
import TeamSelectionAssets

@MainActor
struct PlayersFinder {
    
    private let app: XCUIApplication
    private let table: XCUIElement
    
    @MainActor
    init(app: XCUIApplication, table: XCUIElement) {
        self.app = app
        self.table = table
    }
    
    func nameOfPlayers(inTeam team: Team) -> [String] {
        let rowID = "\(AccessibilityID.playerRow.rawValue)-\(team.name)"
        let predicate = NSPredicate(format: "identifier == %@", rowID)
        let matchingRows = table.buttons.matching(predicate)
        _ = matchingRows.firstMatch.waitForExistence(timeout: 2)

        return (0 ..< matchingRows.count).compactMap { index in
            let label = matchingRows.element(boundBy: index).staticTexts.firstMatch.label
            return label.isEmpty ? nil : label
        }
    }
    
}
