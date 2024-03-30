//
//  ConfirmPlayersUITests.swift
//  UITests
//
//  Created by Radu Dan on 21.10.2021.
//

import XCTest
import CoreModels

final class ConfirmPlayersUITests: UITestCase {
    
    var playersFinder: PlayersFinder!
    
    private var navigator: AppNavigator!
    
    // MARK: - Setup
    
    @MainActor
    override func setUp() {
        super.setUp()
        
        playersFinder = PlayersFinder(app: app, table: confirmTable)
        navigator = .init(app: app, testCase: self)
        
        launchApp(populatingStorage: true)
        navigator.presentPlayerListView()
        navigator.presentConfirmPlayersView()
    }
    
}
