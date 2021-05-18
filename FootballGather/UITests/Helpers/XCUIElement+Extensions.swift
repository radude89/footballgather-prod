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
}

extension XCUIElementQuery {
    subscript(key: AccessibilityID) -> XCUIElement {
        self[key.rawValue]
    }
}
