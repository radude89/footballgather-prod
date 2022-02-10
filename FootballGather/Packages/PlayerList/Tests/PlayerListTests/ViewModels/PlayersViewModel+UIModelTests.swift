//
//  PlayersViewModel+UIModelTests.swift
//  PlayersViewModel+UIModelTests
//
//  Created by Radu Dan on 05.09.2021.
//

import XCTest
import CoreModels
import Localizable
@testable import PlayerList

final class PlayersViewModelUIModelTests: XCTestCase {
    
    private var sut: PlayersViewModel!
    
    override func setUp() {
        super.setUp()
        sut = PlayersViewModel(storage: Mocks.storage)
    }
    
    override func tearDown() {
        super.tearDown()
        Mocks.storage.clear()
    }
    
    func testButtonModelAccessibility() {
        let sut = Mocks.makeButtonModel()
        XCTAssertEqual(sut.accessibilityID, sut.accessibility.id)
        XCTAssertEqual(sut.accessibilityHint, sut.accessibility.hint)
        XCTAssertEqual(sut.accessibilityLabel, sut.accessibility.label)
    }
    
    func testFormattedNavigationTitle_whenIsNotSelectingPlayers_returnsLocalizedStringPlayers() {
        sut.isSelectingPlayers = false
        
        XCTAssertEqual(
            sut.formattedNavigationTitle, LocalizedString.players
        )
    }
    
    func testFormattedNavigationTitle_whenNumberOfSelectedPlayersIsLessThanZero_returnsLocalizedStringPlayers() {
        sut.isSelectingPlayers = false
        XCTAssertEqual(
            sut.formattedNavigationTitle, LocalizedString.players
        )
    }
    
    func testFormattedNavigationTitle_whenHasPlayersAndNoSelectedRows_returnsLocalizedStringPlayers() {
        Player.demoPlayers.forEach { Mocks.storage.updatePlayer($0) }
        sut.isSelectingPlayers = false
        
        XCTAssertEqual(
            sut.formattedNavigationTitle, LocalizedString.players
        )
    }
    
    func testFormattedNavigationTitle_whenHasPlayersAndHasSelectedRows_returnsLocalizedSelectedCount() {
        Player.demoPlayers.forEach { Mocks.storage.updatePlayer($0) }
        
        Player.demoPlayers.forEach { player in
            sut.selectedRows.insert(player.id)
        }
        
        sut.isSelectingPlayers = true
        
        XCTAssertEqual(
            sut.formattedNavigationTitle,
            String(
                format: LocalizedString.selectedCount,
                Player.demoPlayers.count
            )
        )
    }
    
    func testLeadingBarButton_whenNotSelectingPlayers_returnsCorrectButton() {
        let expectedButton = PlayersViewModel.ButtonModel(
            title: LocalizedString.select,
            accessibility: PlayersViewModel.AccessibilityModel(
                id: .selectButton,
                hint: LocalizedString.selectHint,
                label: LocalizedString.select
            )
        )
        let leadingBarButton = sut.leadingBarButton
        
        XCTAssertEqual(leadingBarButton, expectedButton)
    }
    
    func testLeadingBarButton_whenSelectingPlayers_returnsCorrectButton() {
        sut.isSelectingPlayers = true
        
        let expectedButton = PlayersViewModel.ButtonModel(
            title: LocalizedString.cancel,
            accessibility: PlayersViewModel.AccessibilityModel(
                id: .cancelButton,
                hint: LocalizedString.cancelHint,
                label: LocalizedString.cancel
            )
        )
        let leadingBarButton = sut.leadingBarButton
        
        XCTAssertEqual(leadingBarButton, expectedButton)
    }
    
    func testTrailingBarButton_returnsCorrectButton() {
        let expectedButton = PlayersViewModel.ButtonModel(
            title: "",
            accessibility: PlayersViewModel.AccessibilityModel(
                id: .addButton,
                hint: LocalizedString.addPlayersHint,
                label: LocalizedString.addPlayerLabel
            )
        )
        let trailingBarButton = sut.trailingBarButton
        
        XCTAssertEqual(trailingBarButton, expectedButton)
    }
    
    func testMainViewAccessibilityID_whenHasPlayers_isEmptyView() {
        Player.demoPlayers.forEach { Mocks.storage.updatePlayer($0) }
        
        XCTAssertEqual(sut.mainViewAccessibilityID, .playerList)
    }
    
    func testMainViewAccessibilityID_whenHasNotPlayers_isPlayerList() {
        XCTAssertEqual(sut.mainViewAccessibilityID, .emptyView)
    }
    
    func testEditModeBinding_whenIsSelectingPlayers_isActive() {
        sut.isSelectingPlayers = true
        XCTAssertEqual(sut.editModeBinding.wrappedValue, .active)
    }
    
    func testEditModeBinding_whenIsNotSelectingPlayers_isInactive() {
        XCTAssertEqual(sut.editModeBinding.wrappedValue, .inactive)
    }
    
}
