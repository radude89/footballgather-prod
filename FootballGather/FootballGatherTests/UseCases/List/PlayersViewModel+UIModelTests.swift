//
//  PlayersViewModel+UIModelTests.swift
//  PlayersViewModel+UIModelTests
//
//  Created by Radu Dan on 05.09.2021.
//

import XCTest
import CoreModels
import Localizable
@testable import FootballGather

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
    
    func testFormattedNavigationTitle_whenIsEditing_returnsLocalizedStringPlayers() {
        sut.isEditing = true
        
        XCTAssertEqual(
            sut.formattedNavigationTitle, LocalizedString.players
        )
    }
    
    func testFormattedNavigationTitle_whenNumberOfSelectedPlayersIsLessThanZero_returnsLocalizedStringPlayers() {
        XCTAssertEqual(
            sut.formattedNavigationTitle, LocalizedString.players
        )
    }
    
    func testFormattedNavigationTitle_whenHasPlayersAndNoSelectedRows_returnsLocalizedStringPlayers() {
        Player.demoPlayers.forEach { Mocks.storage.updatePlayer($0) }
        
        XCTAssertEqual(
            sut.formattedNavigationTitle, LocalizedString.players
        )
    }
    
    func testFormattedNavigationTitle_whenHasPlayersAndHasSelectedRows_returnsLocalizedSelectedCount() {
        Player.demoPlayers.forEach { Mocks.storage.updatePlayer($0) }
        
        Player.demoPlayers.forEach { player in
            sut.selectedRows.insert(player.id)
        }
        
        XCTAssertEqual(
            sut.formattedNavigationTitle,
            String(
                format: LocalizedString.selectedCount,
                Player.demoPlayers.count
            )
        )
    }
    
    func testLeadingBarButton_whenNotEditing_returnsCorrectButton() {
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
    
    func testLeadingBarButton_whenEditing_returnsCorrectButton() {
        sut.isEditing = true
        
        let expectedButton = PlayersViewModel.ButtonModel(
            title: LocalizedString.done,
            accessibility: PlayersViewModel.AccessibilityModel(
                id: .doneButton,
                hint: LocalizedString.doneHint,
                label: LocalizedString.done
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
    
    func testEditModeBinding_whenIsEditing_isActive() {
        sut.isEditing = true
        XCTAssertEqual(sut.editModeBinding.wrappedValue, .active)
    }
    
    func testEditModeBinding_whenIsNotEditing_isInactive() {
        XCTAssertEqual(sut.editModeBinding.wrappedValue, .inactive)
    }
    
}
