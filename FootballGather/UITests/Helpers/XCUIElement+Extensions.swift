//
//  XCUIElement+Extensions.swift
//  UITests
//
//  Created by Radu Dan on 18.05.2021.
//

import XCTest
import Localizable

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
    subscript(key: AccessibilityID) -> XCUIElement {
        self[key.rawValue]
    }
}

extension UITestCase {
    var cells: [XCUIElement] {
        (0 ..< app.cells.count).enumerated().map { app.cells.element(boundBy: $0.offset) }
    }
    
    var navigationBar: XCUIElement {
        app.navigationBars.element(boundBy: 0)
    }
    
    var confirmTable: XCUIElement {
        app.tables[.confirmPlayersView]
    }
    
    func assertNavigationTitle(is title: String, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(navigationBar.identifier, title, file: file, line: line)
    }
    
    func goBack() {
        app.navigationBars.buttons.element(boundBy: 0).tap()
    }
}
