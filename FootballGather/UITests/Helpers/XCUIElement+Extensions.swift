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
}

extension UITestCase {
    func clearText(of field: XCUIElement) {
        field.doubleTap()
        app.keys["delete"].tap()
    }
}
