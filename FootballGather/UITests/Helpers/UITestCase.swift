//
//  UITestCase.swift
//  UITests
//
//  Created by Radu Dan on 18.05.2021.
//

import XCTest
import FoundationTools

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
    
    func launchApp(populatingStorage: Bool = false) {
        if populatingStorage {
            app.launchArguments.append(Command.populateStorage.rawValue)
        }
        app.launch()
    }
    
}
