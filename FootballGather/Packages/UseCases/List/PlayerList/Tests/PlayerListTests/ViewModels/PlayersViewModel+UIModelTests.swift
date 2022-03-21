//
//  PlayersViewModel+UIModelTests.swift
//  PlayersViewModel+UIModelTests
//
//  Created by Radu Dan on 05.09.2021.
//

import XCTest
import CoreModels
import FoundationTools
import FoundationMocks
import PlayerListAssets
@testable import PlayerList

final class PlayersViewModelUIModelTests: XCTestCase {
    
    func testButtonModelAccessibility() {
        let sut = makeButtonModel()
        
        XCTAssertEqual(sut.accessibilityID, sut.accessibility.id)
        XCTAssertEqual(sut.accessibilityHint, sut.accessibility.hint)
        XCTAssertEqual(sut.accessibilityLabel, sut.accessibility.label)
    }
    
    func testFormattedNavigationTitle_whenIsNotSelectingPlayers_returnsLocalizedStringPlayers() {
        XCTAssertEqual(
            makeSUT().formattedNavigationTitle, LocalizedString.players
        )
    }
    
    func testFormattedNavigationTitle_whenNumberOfSelectedPlayersIsLessThanZero_returnsLocalizedStringPlayers() {
        XCTAssertEqual(
            makeSUT().formattedNavigationTitle, LocalizedString.players
        )
    }
    
    func testFormattedNavigationTitle_whenHasPlayersAndNoSelectedRows_returnsLocalizedStringPlayers() {
        let storage = Mocks.PlayerStorageHandler(storedPlayers: .demoPlayers)
        let sut = makeSUT(storage: storage)
        
        XCTAssertEqual(
            sut.formattedNavigationTitle, LocalizedString.players
        )
    }
    
    func testFormattedNavigationTitle_whenHasPlayersAndHasSelectedRows_returnsLocalizedSelectedCount() {
        let players = Player.demoPlayers
        let storage = Mocks.PlayerStorageHandler(storedPlayers: players)
        let sut = makeSUT(storage: storage)
        
        players.forEach { player in
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
        let leadingBarButton = makeSUT().leadingBarButton
        
        XCTAssertEqual(leadingBarButton, expectedButton)
    }
    
    func testLeadingBarButton_whenSelectingPlayers_returnsCorrectButton() {
        let sut = makeSUT(isSelectingPlayers: true)
        
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
        let trailingBarButton = makeSUT().trailingBarButton
        
        XCTAssertEqual(trailingBarButton, expectedButton)
    }
    
    func testMainViewAccessibilityID_whenHasPlayers_isEmptyView() {
        let sut = makeSUT(storage: Mocks.PlayerStorageHandler(storedPlayers: .demoPlayers))
        
        XCTAssertEqual(sut.mainViewAccessibilityID, .playerList)
    }
    
    func testMainViewAccessibilityID_whenHasNotPlayers_isPlayerList() {
        XCTAssertEqual(makeSUT().mainViewAccessibilityID, .emptyView)
    }
    
    func testEditModeBinding_whenIsSelectingPlayers_isActive() {
        let sut = makeSUT(isSelectingPlayers: true)
        XCTAssertEqual(sut.editModeBinding.wrappedValue, .active)
    }
    
    func testEditModeBinding_whenIsNotSelectingPlayers_isInactive() {
        XCTAssertEqual(makeSUT().editModeBinding.wrappedValue, .inactive)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        storage: PlayerStorageHandler = Mocks.PlayerStorageHandler(),
        isSelectingPlayers: Bool = false
    ) -> PlayersViewModel {
        let sut = PlayersViewModel(storage: storage)
        sut.isSelectingPlayers = isSelectingPlayers
        return sut
    }
    
    private func makeButtonModel(
        title: String = "Button",
        accessibility: PlayersViewModel.AccessibilityModel = .init(
            id: .addButton,
            hint: "Hint",
            label: "Label"
        )
    ) -> PlayersViewModel.ButtonModel {
        .init(title: title, accessibility: accessibility)
    }
    
}
