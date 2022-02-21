//
//  AppNavigator.swift
//  UITests
//
//  Created by Radu Dan on 23.11.2021.
//

import XCTest
import CoreModels
import PlayerListAssets
import GatherAssets

struct AppNavigator {
    
    private let app: XCUIApplication
    private let testCase: UITestCase
    
    init(app: XCUIApplication, testCase: UITestCase) {
        self.app = app
        self.testCase = testCase
    }
    
    func presentPlayerListView() {
        XCTAssertTrue(app.otherElements[.playerList].waitToAppear())
    }
    
    func presentConfirmPlayersView() {
        selectPlayers()
        confirmSelection()
        waitConfirmViewToAppear()
    }
    
    private func selectPlayers() {
        app.buttons[.selectButton].tap()
        testCase.cells[0].tap()
        testCase.cells[1].tap()
    }
    
    private func confirmSelection() {
        app.buttons[.confirmButton].tap()
    }
    
    private func waitConfirmViewToAppear() {
        testCase.assertNavigationTitle(is: LocalizedString.confirmPlayersTitle)
        XCTAssertTrue(app.tables[.confirmPlayersView].waitToAppear())
    }
    
    func presentGatherView() {
        presentPlayerListView()
        presentConfirmPlayersView()
        movePlayers()
        startGather()
        waitForGatherViewToAppear()
    }
    
    private func movePlayers() {
        let playerMover = PlayerMover(app: app, table: testCase.confirmTable)
        playerMover.move("John", to: .teamA)
        playerMover.move("Jane", to: .teamB)
    }
    
    private func startGather() {
        let startGatherButton = app.buttons[.startGatherButton]
        XCTAssertTrue(startGatherButton.isEnabled)
        startGatherButton.tap()
    }
    
    private func waitForGatherViewToAppear() {
        testCase.assertNavigationTitle(is: LocalizedString.gatherInProgress)
        XCTAssertTrue(app.tables[.gatherPlayersList].waitToAppear())
    }
    
}
