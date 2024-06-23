//
//  XCUIElement+Extensions.swift
//  UITests
//
//  Created by Radu Dan on 18.05.2021.
//

import XCTest
import HistoryAssets
import PlayerListAssets
import PlayerDetailsAssets
import TeamSelectionAssets
import GatherAssets

extension XCUIElement {
    func waitToAppear(timeout: TimeInterval = 2) -> Bool {
        waitForExistence(timeout: timeout)
    }
    
    func dismissKeyboard() {
        typeText("\n")
    }
    
    var isTicked: Bool {
        images["Selected"].exists
    }
    
    func clearText() {
        guard let text = value as? String, !text.isEmpty else {
            return
        }
        
        text.forEach { _ in typeText(XCUIKeyboardKey.delete.rawValue) }
    }
    
    var pickerValue: String? {
        pickerWheels.firstMatch.value as? String
    }
    
    func scroll(toPickerWheelValue value: String) {
        pickerWheels.element.adjust(toPickerWheelValue: value)
    }
}

extension XCUIElementQuery {
    subscript(key: TeamSelectionAssets.AccessibilityID) -> XCUIElement {
        self[key.rawValue]
    }
    
    subscript(key: PlayerDetailsAssets.AccessibilityID) -> XCUIElement {
        self[key.rawValue]
    }
    
    subscript(key: GatherAssets.AccessibilityID) -> XCUIElement {
        self[key.rawValue]
    }
    
    subscript(key: PlayerListAssets.AccessibilityID) -> XCUIElement {
        self[key.rawValue]
    }
    
    subscript(key: HistoryAssets.AccessibilityID) -> XCUIElement {
        self[key.rawValue]
    }
}

extension UITestCase {
    @MainActor
    var cells: [XCUIElement] {
        (0 ..< app.cells.count).enumerated().map { app.cells.element(boundBy: $0.offset) }
    }
    
    @MainActor
    var navigationBar: XCUIElement {
        app.navigationBars.element(boundBy: 0)
    }
    
    @MainActor
    var confirmTable: XCUIElement {
        app.tables[AccessibilityID.confirmPlayersView.rawValue]
    }
    
    @MainActor
    func assertNavigationTitle(is title: String, file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertEqual(navigationBar.identifier, title, file: file, line: line)
    }
    
    @MainActor
    func goBack() {
        app.navigationBars.buttons.element(boundBy: 0).tap()
    }
}

extension XCUIElement {
    func labelContains(text: String) -> Bool {
        let predicate = NSPredicate(format: "label CONTAINS %@", text)
        return staticTexts.matching(predicate).firstMatch.exists
    }
}
