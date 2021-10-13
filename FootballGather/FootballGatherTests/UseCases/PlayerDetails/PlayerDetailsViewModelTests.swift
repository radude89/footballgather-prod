//
//  PlayerDetailsViewModelTests.swift
//  PlayerDetailsViewModelTests
//
//  Created by Radu Dan on 12.09.2021.
//

import XCTest
import Combine
import CoreModels
import Localizable
@testable import FootballGather

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
        sut.selectedPlayer.name = "Jane"
        XCTAssertTrue(sut.playerIsValid)
    }
    
    func testPlayerIsValid_whenNameIsEmpty_isFalse() {
        XCTAssertFalse(sut.playerIsValid)
    }
    
    func testPlayerIsValid_whenNameStartsWithSpace_isFalse() {
        sut.selectedPlayer.name = " Thomas"
        XCTAssertFalse(sut.playerIsValid)
    }
    
    func testPlayerIsValid_whenNameIsAllSpaces_isFalse() {
        (0...10).forEach { index in
            sut.selectedPlayer.name = String(repeating: " ", count: index)
            XCTAssertFalse(sut.playerIsValid)
        }
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
    
    func testIsAddingPlayers_whenStateIsAddingPlayers_isTrue() {
        XCTAssertTrue(sut.isAddingPlayers)
    }
    
    func testIsAddingPlayers_whenStateIsViewingDetails_isFalse() {
        let sut = PlayerDetailsViewModel(
            storage: Mocks.storage,
            state: .viewingDetails
        )
        
        XCTAssertFalse(sut.isAddingPlayers)
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
        
        XCTAssertEqual(sut.viewAccessibilityID, .detailsView)
    }
    
}
