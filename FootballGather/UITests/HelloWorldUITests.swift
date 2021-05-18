//
//  HelloWorldUITests.swift
//  Football GatherUITests
//
//  Created by Radu Dan on 25.03.2021.
//

import XCTest
import Localizable

final class HelloWorldUITests: XCTestCase {
    
    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = true

        app = XCUIApplication()
        app.launch()
    }
    
    func testHelloWorld() {
        let helloText = app.staticTexts[.hello]

        XCTAssertTrue(helloText.exists)
        XCTAssertEqual(helloText.label, LocalizedText.hello)
    }

}
