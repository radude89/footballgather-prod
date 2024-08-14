//
//  ConfirmPlayersUITests.swift
//  UITests
//
//  Created by Radu Dan on 21.10.2021.
//

import XCTest
import CoreModels

final class ConfirmPlayersUITests: UITestCase, @unchecked Sendable {
    
    var playersFinder: PlayersFinder!
    
    private var navigator: AppNavigator!
    
    // MARK: - Setup

    override func setUp() async throws {
        try await super.setUp()
        
        playersFinder = await PlayersFinder(app: app, table: confirmTable)
        navigator = await .init(app: app, testCase: self)
        
        await launchApp(populatingStorage: true)
        await navigator.presentPlayerListView()
        await navigator.presentConfirmPlayersView()
    }
    
}
