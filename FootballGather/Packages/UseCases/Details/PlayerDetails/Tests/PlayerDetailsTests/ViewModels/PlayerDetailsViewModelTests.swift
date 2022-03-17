//
//  PlayerDetailsViewModelTests.swift
//  PlayerDetailsViewModelTests
//
//  Created by Radu Dan on 12.09.2021.
//

import XCTest
import SwiftUI
import Combine
import CoreModels
import PlayerDetailsAssets
import FoundationMocks
@testable import PlayerDetails

final class PlayerDetailsViewModelTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable>!
    private let allSkills = Player.Skill.allCases
    private let allPositions = Player.Position.allCases
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }
    
    override func tearDown() {
        cancellables = []
        super.tearDown()
    }
    
    func testSelectedPlayer() throws {
        var expectedPlayerNames = ["", "John"]
        let receivedAllExpectation = expectation(description: "Adding player expectation")
        let sut = makeSUT()
                
        sut.$selectedPlayer
            .sink { player in
                guard let expectedPlayerName = expectedPlayerNames.first else {
                    XCTFail("Received more values than expected.")
                    return
                }
                
                guard expectedPlayerName == player.name else {
                    XCTFail("Expected received \(player.name) to match first expected \(expectedPlayerName)")
                    return
                }
                
                expectedPlayerNames = Array(expectedPlayerNames.dropFirst())
                
                if expectedPlayerNames.isEmpty {
                    receivedAllExpectation.fulfill()
                }
                
            }
            .store(in: &cancellables)
        
        sut.selectedPlayer.name = "John"
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testPlayerIsValid_whenNameIsNotEmpty_isTrue() {
        PlayerDetailsViewModel.State.allCases.forEach { state in
            let sut = makeSUT(state: state)
            
            sut.selectedPlayer.name = "Jane"
            
            XCTAssertTrue(sut.playerIsValid)
        }
    }
    
    func testPlayerIsValid_whenNameIsEmpty_isFalse() {
        PlayerDetailsViewModel.State.allCases.forEach { state in
            XCTAssertFalse(makeSUT(state: state).playerIsValid)
        }
    }
    
    func testPlayerIsValid_whenNameStartsWithSpace_isFalse() {
        PlayerDetailsViewModel.State.allCases.forEach { state in
            let sut = makeSUT(state: state)
            
            sut.selectedPlayer.name = " Thomas"
            
            XCTAssertFalse(sut.playerIsValid)
        }
    }
    
    func testPlayerIsValid_whenNameIsAllSpaces_isFalse() {
        PlayerDetailsViewModel.State.allCases.forEach { state in
            let sut = makeSUT(state: state)
            
            (0...10).forEach { index in
                sut.selectedPlayer.name = String(repeating: " ", count: index)
                XCTAssertFalse(sut.playerIsValid)
            }
        }
    }
    
    func testPlayerIsValid_whenStateIsViewingDetailsAndHasEnteredTheSameName_isFalse() {
        let player = Player(name: "Mike")
        let storage = Mocks.PlayerStorageHandler(storedPlayers: [player])
        let sut = makeSUT(storage: storage, state: .viewingDetails, player: player)
        
        sut.selectedPlayer.name = "Mike"
        
        XCTAssertFalse(sut.playerIsValid)
    }
    
    func testPlayerIsValid_whenStateIsViewingDetailsAndHasEnteredDifferentNames_isTrue() {
        let player = Player(name: "Mike")
        let storage = Mocks.PlayerStorageHandler(storedPlayers: [player])
        let sut = makeSUT(storage: storage, state: .viewingDetails, player: player)
        
        sut.selectedPlayer.name = "Mike2"
        
        XCTAssertTrue(sut.playerIsValid)
    }
    
    func testPlayerIsValid_whenEnteringDifferentPositions_isTrue() {
        let player = Player(name: "Mike")
        let storage = Mocks.PlayerStorageHandler(storedPlayers: [player])
        let sut = makeSUT(storage: storage, state: .viewingDetails, player: player)
        
        sut.selectedPlayer.position = allPositions.randomElement()
        
        XCTAssertTrue(sut.playerIsValid)
    }
    
    func testPlayerIsValid_whenEnteringDifferentSkills_isTrue() {
        let player = Player(name: "Andrew")
        let storage = Mocks.PlayerStorageHandler(storedPlayers: [player])
        let sut = makeSUT(storage: storage, state: .viewingDetails, player: player)
        
        sut.selectedPlayer.skill = allSkills.randomElement()
        
        XCTAssertTrue(sut.playerIsValid)
    }
    
    func testHasEnteredDetails_whenNameIsNotEmpty_isTrue() {
        let sut = makeSUT()
        
        sut.selectedPlayer.name = "Perry"
        
        XCTAssertTrue(sut.hasEnteredDetails)
    }
    
    func testHasEnteredDetails_whenSkillIsNotEmpty_isTrue() {
        allSkills.forEach { skill in
            let sut = makeSUT()
            
            sut.selectedPlayer.skill = skill
            
            XCTAssertTrue(sut.hasEnteredDetails)
        }
    }
    
    func testHasEnteredDetails_whenPositionIsNotEmpty_isTrue() {
        allPositions.forEach { position in
            let sut = makeSUT()
            
            sut.selectedPlayer.position = position
            
            XCTAssertTrue(sut.hasEnteredDetails)
        }
    }
    
    func testHasEnteredDetails_isFalse() {
        XCTAssertFalse(makeSUT().hasEnteredDetails)
    }
    
    func testSavePlayer_addsToStorage() {
        let storage = Mocks.PlayerStorageHandler()
        let sut = makeSUT(storage: storage, player: Player(name: "Doe"))
        
        sut.savePlayer()
        
        XCTAssertTrue(storage.updatePlayerCalled)
    }
    
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
    
    func testIsAddingPlayer_whenStateIsAddingPlayers_isTrue() {
        XCTAssertTrue(makeSUT().isAddingPlayer)
    }
    
    func testIsAddingPlayer_whenStateIsViewingDetails_isFalse() {
        XCTAssertFalse(makeSUT(state: .viewingDetails).isAddingPlayer)
    }
    
    func testFormattedNavigationBarTitle_whenStateIsViewingDetails_isPlayerName() {
        let sut = makeSUT(
            state: .viewingDetails,
            player: Player(name: "Jerry")
        )
        
        XCTAssertEqual(sut.formattedNavigationBarTitle, "Jerry")
    }
    
    func testFormattedNavigationBarTitle_whenStateIsAddingPlayers_isPlayerDetailsModelNavigationTitle() {
        let detailsModel = PlayerDetailsUIModelFactory.makeDetailsModel(
            for: .demo, state: .addingPlayers
        )
        
        XCTAssertEqual(makeSUT().formattedNavigationBarTitle, detailsModel.navigationTitle)
    }
    
    func testShowLeadingBarItem_whenStateIsAddingPlayers_isTrue() {
        XCTAssertTrue(makeSUT().showLeadingBarItem)
    }
    
    func testShowLeadingBarItem_whenStateIsViewingDetails_isFalse() {
        XCTAssertFalse(makeSUT(state: .viewingDetails).showLeadingBarItem)
    }
    
    func testViewAccessibilityID_whenStateIsAddingPlayers_isAddView() {
        XCTAssertEqual(makeSUT().viewAccessibilityID, .addView)
    }
    
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
