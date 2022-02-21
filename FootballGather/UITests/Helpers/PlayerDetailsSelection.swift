//
//  PlayerDetailsSelection.swift
//  UITests
//
//  Created by Radu Dan on 14.10.2021.
//

import XCTest
import CoreModels
import PlayerDetailsAssets

struct PlayerDetailsSelection {
    private let app: XCUIApplication
    
    enum CellType {
        case skill
        case position
    }
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    func selectSkill(at index: Int = .random(in: 0..<Player.Skill.allCases.count)) {
        app.cells.element(boundBy: index).tap()
    }
    
    func selectPosition(at index: Int = .random(in: 0..<Player.Position.allCases.count)) {
        app.cells.element(boundBy: index).tap()
    }
    
    func selectCell(_ type: CellType) {
        let cell = cell(of: type)
        scrollIfNeeded(to: cell)
        cell.tap()
    }
    
    private func cell(of type: CellType) -> XCUIElement {
        switch type {
        case .skill:
            return app.cells[LocalizedString.skill]
        case .position:
            return app.cells[LocalizedString.position]
        }
    }
    
    private func scrollIfNeeded(to cell: XCUIElement) {
        if !cell.exists {
            app.swipeUp()
        }
    }
}
