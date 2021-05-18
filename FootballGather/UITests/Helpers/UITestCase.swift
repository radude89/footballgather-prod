//
//  UITestCase.swift
//  UITests
//
//  Created by Radu Dan on 18.05.2021.
//

import XCTest

class UITestCase: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launchArguments = ["-uitests"]
    }
    
    override func tearDownWithError() throws {
        app.terminate()
        try super.tearDownWithError()
    }
    
    func launchApp() {
        app.launch()
    }
    
}
