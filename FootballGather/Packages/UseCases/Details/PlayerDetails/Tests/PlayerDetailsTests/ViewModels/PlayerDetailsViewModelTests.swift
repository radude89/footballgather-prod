//
//  PlayerDetailsViewModelTests.swift
//  PlayerDetailsViewModelTests
//
//  Created by Radu Dan on 12.09.2021.
//

import XCTest
import SwiftUI
import CoreModels
import PlayerDetailsAssets
import FoundationMocks
@testable import PlayerDetails

final class PlayerDetailsViewModelTests: XCTestCase {
    
    private let allSkills = Player.Skill.allCases
    private let allPositions = Player.Position.allCases
    
    @MainActor
    func testPlayerIsValid_whenNameIsNotEmpty_isTrue() {
        PlayerDetailsViewModel.State.allCases.forEach { state in
            let sut = makeSUT(state: state)
            
            sut.selectedPlayer.name = "Jane"
            
            XCTAssertTrue(sut.playerIsValid)
        }
    }
    
    @MainActor
    func testPlayerIsValid_whenNameIsEmpty_isFalse() {
        PlayerDetailsViewModel.State.allCases.forEach { state in
            XCTAssertFalse(makeSUT(state: state).playerIsValid)
        }
    }
    
    @MainActor
    func testPlayerIsValid_whenNameStartsWithSpace_isFalse() {
        PlayerDetailsViewModel.State.allCases.forEach { state in
            let sut = makeSUT(state: state)
            
            sut.selectedPlayer.name = " Thomas"
            
            XCTAssertFalse(sut.playerIsValid)
        }
    }
    
    @MainActor
    func testPlayerIsValid_whenNameIsAllSpaces_isFalse() {
        PlayerDetailsViewModel.State.allCases.forEach { state in
            let sut = makeSUT(state: state)
            
            (0...10).forEach { index in
                sut.selectedPlayer.name = String(repeating: " ", count: index)
                XCTAssertFalse(sut.playerIsValid)
            }
        }
    }
    
    @MainActor
    func testPlayerIsValid_whenStateIsViewingDetailsAndHasEnteredTheSameName_isFalse() {
        let player = Player(name: "Mike")
        let storage = Mocks.PlayerStorageHandler(storedPlayers: [player])
        let sut = makeSUT(storage: storage, state: .viewingDetails, player: player)
        
        sut.selectedPlayer.name = "Mike"
        
        XCTAssertFalse(sut.playerIsValid)
    }
    
    @MainActor
    func testPlayerIsValid_whenStateIsViewingDetailsAndHasEnteredDifferentNames_isTrue() {
        let player = Player(name: "Mike")
        let storage = Mocks.PlayerStorageHandler(storedPlayers: [player])
        let sut = makeSUT(storage: storage, state: .viewingDetails, player: player)
        
        sut.selectedPlayer.name = "Mike2"
        
        XCTAssertTrue(sut.playerIsValid)
    }
    
    @MainActor
    func testPlayerIsValid_whenEnteringDifferentPositions_isTrue() {
        let player = Player(name: "Mike")
        let storage = Mocks.PlayerStorageHandler(storedPlayers: [player])
        let sut = makeSUT(storage: storage, state: .viewingDetails, player: player)
        
        sut.selectedPlayer.position = Player.Position.midfielder
        
        XCTAssertTrue(sut.playerIsValid)
    }
    
    @MainActor
    func testPlayerIsValid_whenEnteringDifferentSkills_isTrue() {
        let player = Player(name: "Andrew")
        let storage = Mocks.PlayerStorageHandler(storedPlayers: [player])
        let sut = makeSUT(storage: storage, state: .viewingDetails, player: player)
        
        sut.selectedPlayer.skill = Player.Skill.amateur
        
        XCTAssertTrue(sut.playerIsValid)
    }
    
    @MainActor
    func testHasEnteredDetails_whenNameIsNotEmpty_isTrue() {
        let sut = makeSUT()
        
        sut.selectedPlayer.name = "Perry"
        
        XCTAssertTrue(sut.hasEnteredDetails)
    }
    
    @MainActor
    func testHasEnteredDetails_whenSkillIsNotEmpty_isTrue() {
        allSkills.forEach { skill in
            let sut = makeSUT(player: .init(name: "John"))
            
            sut.selectedPlayer.skill = skill
            
            XCTAssertTrue(sut.hasEnteredDetails)
        }
    }
    
    @MainActor
    func testHasEnteredDetails_whenPositionIsNotEmpty_isTrue() {
        allPositions.forEach { position in
            let sut = makeSUT(player: .init(name: "John"))
            
            sut.selectedPlayer.position = position
            
            XCTAssertTrue(sut.hasEnteredDetails)
        }
    }
    
    @MainActor
    func testHasEnteredDetails_isFalse() {
        XCTAssertFalse(makeSUT().hasEnteredDetails)
    }
    
    @MainActor
    func testSavePlayer_addsToStorage() {
        let storage = Mocks.PlayerStorageHandler()
        let sut = makeSUT(storage: storage, player: Player(name: "Doe"))
        
        sut.savePlayer()
        
        XCTAssertTrue(storage.updatePlayerCalled)
    }
    
    @MainActor
    func testUpdateBindingToShowListView_setsToTrue() {
        var showListView = false
        let showListViewBinding = Binding<Bool>(
            get: { showListView },
            set: { showListView = $0 }
        )
        let sut = makeSUT(showListView: showListViewBinding)
        
        sut.updateBindingToShowListView()
        
        XCTAssertTrue(sut.showListView)
    }
    
    @MainActor
    func testIsAddingPlayer_whenStateIsAddingPlayers_isTrue() {
        XCTAssertTrue(makeSUT().isAddingPlayer)
    }
    
    @MainActor
    func testIsAddingPlayer_whenStateIsViewingDetails_isFalse() {
        XCTAssertFalse(makeSUT(state: .viewingDetails).isAddingPlayer)
    }
    
    @MainActor
    func testFormattedNavigationBarTitle_whenStateIsViewingDetails_isPlayerName() {
        let sut = makeSUT(
            state: .viewingDetails,
            player: Player(name: "Jerry")
        )
        
        XCTAssertEqual(sut.formattedNavigationBarTitle, "Jerry")
    }
    
    @MainActor
    func testFormattedNavigationBarTitle_whenStateIsAddingPlayers_isPlayerDetailsModelNavigationTitle() {
        let detailsModel = PlayerDetailsUIModelFactory.makeDetailsModel(
            for: .demo, state: .addingPlayers
        )
        
        XCTAssertEqual(makeSUT().formattedNavigationBarTitle, detailsModel.navigationTitle)
    }
    
    @MainActor
    func testShowLeadingBarItem_whenStateIsAddingPlayers_isTrue() {
        XCTAssertTrue(makeSUT().showLeadingBarItem)
    }
    
    @MainActor
    func testShowLeadingBarItem_whenStateIsViewingDetails_isFalse() {
        XCTAssertFalse(makeSUT(state: .viewingDetails).showLeadingBarItem)
    }
    
    @MainActor
    func testViewAccessibilityID_whenStateIsAddingPlayers_isAddView() {
        XCTAssertEqual(makeSUT().viewAccessibilityID, .addView)
    }
    
    @MainActor
    func testViewAccessibilityID_whenStateIsViewingPlayers_isDetailsView() {
        XCTAssertEqual(
            makeSUT(state: .viewingDetails).viewAccessibilityID, .detailsView
        )
    }
    
    // MARK: - Helpers
    
    private func makeStorage(
        players: [Player] = []
    ) -> Mocks.PlayerStorageHandler {
        .init(storedPlayers: players)
    }
    
    @MainActor
    private func makeSUT(
        storage: Mocks.PlayerStorageHandler = .init(),
        state: PlayerDetailsViewModel.State = .addingPlayers,
        player: Player = .init(name: ""),
        showListView: Binding<Bool> = .constant(false)
    ) -> PlayerDetailsViewModel {
        .init(
            storage: storage,
            state: state,
            player: player,
            showListView: showListView
        )
    }
    
}
