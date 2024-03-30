//
//  PlayerMover.swift
//  UITests
//
//  Created by Radu Dan on 23.11.2021.
//

import XCTest
import CoreModels

@MainActor
struct PlayerMover {
    
    private let app: XCUIApplication
    private let table: XCUIElement
    
    init(app: XCUIApplication, table: XCUIElement) {
        self.app = app
        self.table = table
    }
    
    func move(_ playerName: String, to team: Team) {
        let sectionLabel = table.staticTexts[team.name.uppercased()]
        
        app.buttons["Reorder \(playerName)"]
            .press(forDuration: 0.3, thenDragTo: sectionLabel)
    }
    
}
