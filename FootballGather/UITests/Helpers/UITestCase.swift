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
    
    @MainActor lazy var saveButton = app.buttons[.saveButton]

    @MainActor
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launchArguments = ["-uitests"]
    }
    
    @MainActor
    override func tearDownWithError() throws {
        app.terminate()
        try super.tearDownWithError()
    }
    
    @MainActor
    func launchApp(populatingStorage: Bool = false) {
        if populatingStorage {
            app.launchArguments.append(Command.populateStorage.rawValue)
        }
        app.launch()
    }
    
}
