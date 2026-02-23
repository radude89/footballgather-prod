//
//  UITestCase.swift
//  UITests
//
//  Created by Radu Dan on 18.05.2021.
//

import XCTest
import FoundationTools
import PlayerDetailsAssets

class UITestCase: XCTestCase, @unchecked Sendable {
    
    var app: XCUIApplication!
    
    @MainActor lazy var saveButton = app.buttons[.saveButton]
    
    override func setUp() async throws {
        try await super.setUp()
        
        continueAfterFailure = false
        
        app = await XCUIApplication()
    }
    
    override func tearDown() async throws {
        await app.terminate()
        try await super.tearDown()
    }
    
    @MainActor
    func launchApp(populatingStorage: Bool = false) {
        app.launchArguments.append(Command.runUITests.rawValue)
        if populatingStorage {
            app.launchArguments.append(Command.populateStorage.rawValue)
        }
        app.launch()
    }
    
    func wait(for duration: TimeInterval = 1.0) {
        RunLoop.current.run(until: Date(timeIntervalSinceNow: duration))
    }
}
