//
//  ConfirmPlayersUITests.swift
//  UITests
//
//  Created by Radu Dan on 21.10.2021.
//

import XCTest
import Localizable
import CoreModels

final class ConfirmPlayersUITests: UITestCase {
    
    var playersFinder: PlayersFinder!
    
    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        
        playersFinder = PlayersFinder(app: app, table: confirmTable)
        
        launchApp(populatingStorage: true)
        presentPlayerListView()
        presentConfirmPlayersView()
    }
    
    var confirmTable: XCUIElement {
        app.tables[.confirmPlayersView]
    }
    
    private func presentPlayerListView() {
        XCTAssertTrue(app.otherElements[.playerList].waitToAppear())
    }
    
    private func presentConfirmPlayersView() {
        selectPlayers()
        confirmSelection()
        
        assertNavigationTitle(is: LocalizedString.confirmPlayersTitle)
        XCTAssertTrue(confirmTable.waitToAppear())
    }
    
    private func selectPlayers() {
        app.buttons[.selectButton].tap()
        cells[0].tap()
        cells[1].tap()
    }
    
    private func confirmSelection() {
        app.buttons[.confirmButton].tap()
    }
    
}
