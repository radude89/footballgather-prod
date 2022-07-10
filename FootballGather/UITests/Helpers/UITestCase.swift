//
//  UITestCase.swift
//  UITests
//
//  Created by Radu Dan on 18.05.2021.
//

import XCTest
import FoundationTools
import PlayerDetailsAssets

class UITestCase: XCTestCase {
    
    var app: XCUIApplication!
    
    lazy var saveButton = app.buttons[.saveButton]
    
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
