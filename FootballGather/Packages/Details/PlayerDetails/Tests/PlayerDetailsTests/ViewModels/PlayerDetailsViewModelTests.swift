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
import Localizable
@testable import PlayerDetails

final class PlayerDetailsViewModelTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable>!
    private var sut: PlayerDetailsViewModel!
    private let allSkills = Player.Skill.allCases
    private let allPositions = Player.Position.allCases
    
    override func setUp() {
        super.setUp()
        
        cancellables = []
        
        sut = PlayerDetailsViewModel(
            storage: Mocks.storage,
            state: .addingPlayers
        )
    }
    
    override func tearDown() {
        cancellables = []
        Mocks.storage.clear()
        
        super.tearDown()
    }
    
    func testSelectedPlayer() throws {
        var expectedPlayerNames = ["", "John"]
        let receivedAllExpectation = expectation(description: "Adding player expectation")
                
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
            let sut = PlayerDetailsViewModel(
                storage: Mocks.storage,
                state: state
            )
            
            sut.selectedPlayer.name = "Jane"
            
            XCTAssertTrue(sut.playerIsValid)
        }
    }
    
    func testPlayerIsValid_whenNameIsEmpty_isFalse() {
        PlayerDetailsViewModel.State.allCases.forEach { state in
            let sut = PlayerDetailsViewModel(
                storage: Mocks.storage,
                state: state
            )
            
            XCTAssertFalse(sut.playerIsValid)
        }
    }
    
    func testPlayerIsValid_whenNameStartsWithSpace_isFalse() {
        PlayerDetailsViewModel.State.allCases.forEach { state in
            let sut = PlayerDetailsViewModel(
                storage: Mocks.storage,
                state: state
            )
            
            sut.selectedPlayer.name = " Thomas"
            
            XCTAssertFalse(sut.playerIsValid)
        }
    }
    
    func testPlayerIsValid_whenNameIsAllSpaces_isFalse() {
        PlayerDetailsViewModel.State.allCases.forEach { state in
            let sut = PlayerDetailsViewModel(
                storage: Mocks.storage,
                state: state
            )
            
            (0...10).forEach { index in
                sut.selectedPlayer.name = String(repeating: " ", count: index)
                XCTAssertFalse(sut.playerIsValid)
            }
        }
    }
    
    func testPlayerIsValid_whenStateIsViewingDetailsAndHasEnteredTheSameName_isFalse() {
        let player = Player(name: "Mike")
        Mocks.storage.updatePlayer(player)
        
        let sut = PlayerDetailsViewModel(
            storage: Mocks.storage,
            state: .viewingDetails,
            player: player
        )
        
        sut.selectedPlayer.name = "Mike"
        
        XCTAssertFalse(sut.playerIsValid)
    }
    
    func testPlayerIsValid_whenStateIsViewingDetailsAndHasEnteredDifferentNames_isTrue() {
        let player = Player(name: "Mike")
        Mocks.storage.updatePlayer(player)
        
        let sut = PlayerDetailsViewModel(
            storage: Mocks.storage,
            state: .viewingDetails,
            player: player
        )
        
        sut.selectedPlayer.name = "Mike2"
        
        XCTAssertTrue(sut.playerIsValid)
    }
    
    func testPlayerIsValid_whenEnteringDifferentPositions_isTrue() {
        let player = Player(name: "Mike")
        Mocks.storage.updatePlayer(player)
        
        let sut = PlayerDetailsViewModel(
            storage: Mocks.storage,
            state: .viewingDetails,
            player: player
        )
        
        sut.selectedPlayer.position = allPositions.randomElement()
        
        XCTAssertTrue(sut.playerIsValid)
    }
    
    func testPlayerIsValid_whenEnteringDifferentSkills_isTrue() {
        let player = Player(name: "Andrew")
        Mocks.storage.updatePlayer(player)
        
        let sut = PlayerDetailsViewModel(
            storage: Mocks.storage,
            state: .viewingDetails,
            player: player
        )
        
        sut.selectedPlayer.skill = allSkills.randomElement()
        
        XCTAssertTrue(sut.playerIsValid)
    }
    
    func testHasEnteredDetails_whenNameIsNotEmpty_isTrue() {
        sut.selectedPlayer.name = "Perry"
        XCTAssertTrue(sut.hasEnteredDetails)
    }
    
    func testHasEnteredDetails_whenSkillIsNotEmpty_isTrue() {
        allSkills.forEach { skill in
            sut.selectedPlayer.skill = skill
            XCTAssertTrue(sut.hasEnteredDetails)
        }
    }
    
    func testHasEnteredDetails_whenPositionIsNotEmpty_isTrue() {
        allPositions.forEach { position in
            sut.selectedPlayer.position = position
            XCTAssertTrue(sut.hasEnteredDetails)
        }
    }
    
    func testHasEnteredDetails_isFalse() {
        XCTAssertFalse(sut.hasEnteredDetails)
    }
    
    func testSavePlayer_addsToStorage() {
        sut.selectedPlayer.name = "Doe"
        sut.savePlayer()
        
        let storedPlayers = Mocks.storage.storedPlayers
        XCTAssertEqual(storedPlayers.count, 1)
        XCTAssertTrue(
            storedPlayers.contains(sut.selectedPlayer)
        )
    }
    
    func testUpdateBindingToShowListView_setsToTrue() {
        var showListView = false
        let showListViewBinding = Binding<Bool>(
            get: { showListView },
            set: { showListView = $0 }
        )
        let sut = PlayerDetailsViewModel(
            storage: Mocks.storage,
            state: .addingPlayers,
            showListView: showListViewBinding
        )
        
        sut.updateBindingToShowListView()
        
        XCTAssertTrue(sut.showListView)
    }
    
    func testIsAddingPlayer_whenStateIsAddingPlayers_isTrue() {
        XCTAssertTrue(sut.isAddingPlayer)
    }
    
    func testIsAddingPlayer_whenStateIsViewingDetails_isFalse() {
        let sut = PlayerDetailsViewModel(
            storage: Mocks.storage,
            state: .viewingDetails
        )
        
        XCTAssertFalse(sut.isAddingPlayer)
    }
    
    func testFormattedNavigationBarTitle_whenStateIsViewingDetails_isPlayerName() {
        let playerName = "Jerry"
        let sut = PlayerDetailsViewModel(
            storage: Mocks.storage,
            state: .viewingDetails
        )
        sut.selectedPlayer.name = playerName
        
        XCTAssertEqual(sut.formattedNavigationBarTitle, playerName)
    }
    
    func testFormattedNavigationBarTitle_whenStateIsAddingPlayers_isPlayerDetailsModelNavigationTitle() {
        let detailsModel = PlayerDetailsUIModelFactory.makeDetailsModel(
            for: .demo, state: .addingPlayers
        )
        
        
        XCTAssertEqual(sut.formattedNavigationBarTitle, detailsModel.navigationTitle)
    }
    
    func testShowLeadingBarItem_whenStateIsAddingPlayers_isTrue() {
        XCTAssertTrue(sut.showLeadingBarItem)
    }
    
    func testShowLeadingBarItem_whenStateIsViewingDetails_isFalse() {
        let sut = PlayerDetailsViewModel(
            storage: Mocks.storage,
            state: .viewingDetails
        )
        
        XCTAssertFalse(sut.showLeadingBarItem)
    }
    
    func testViewAccessibilityID_whenStateIsAddingPlayers_isAddView() {
        XCTAssertEqual(sut.viewAccessibilityID, .addView)
    }
    
    func testViewAccessibilityID_whenStateIsViewingPlayers_isDetailsView() {
        let sut = PlayerDetailsViewModel(
            storage: Mocks.storage,
            state: .viewingDetails
        )
        
        XCTAssertEqual(sut.viewAccessibilityID, Localizable.AccessibilityID.detailsView)
    }
    
}
