//
//  PlayerDetailsViewModelIntegrationTests.swift
//  
//
//  Created by Radu Dan on 17.03.2022.
//

import XCTest
import CoreModels
import FoundationMocks
import FoundationTools
@testable import PlayerDetails

@MainActor
final class PlayerDetailsViewModelIntegrationTests: XCTestCase {
    
    override func tearDown() {
        Mocks.storage.clear()
        super.tearDown()
    }
 
    func testPlayerIsValid_whenStateIsViewingDetailsAndHasEnteredTheSameName_isFalse() {
        let player = Player(name: "Mike")
        let storage = makeAppStorage(players: [player])
        let sut = makeSUT(storage: storage, player: player)

        sut.selectedPlayer.name = "Mike"

        XCTAssertFalse(sut.playerIsValid)
    }

    func testPlayerIsValid_whenStateIsViewingDetailsAndHasEnteredDifferentNames_isTrue() {
        let player = Player(name: "Mike")
        let storage = makeAppStorage(players: [player])
        let sut = makeSUT(storage: storage, player: player)

        sut.selectedPlayer.name = "Mike2"

        XCTAssertTrue(sut.playerIsValid)
    }

    func testPlayerIsValid_whenEnteringDifferentPositions_isTrue() {
        let player = Player(name: "Mike")
        let storage = makeAppStorage(players: [player])
        let sut = makeSUT(storage: storage, player: player)

        sut.selectedPlayer.position = Player.Position.goalkeeper

        XCTAssertTrue(sut.playerIsValid)
    }

    func testPlayerIsValid_whenEnteringDifferentSkills_isTrue() {
        let player = Player(name: "Andrew")
        let storage = makeAppStorage(players: [player])
        let sut = makeSUT(storage: storage, player: player)

        sut.selectedPlayer.skill = Player.Skill.amateur

        XCTAssertTrue(sut.playerIsValid)
    }

    func testSavePlayer_addsToStorage() {
        let storage = makeAppStorage()
        let sut = makeSUT(storage: storage)
        sut.selectedPlayer.name = "Doe"
        
        sut.savePlayer()

        let storedPlayers = storage.storedPlayers
        XCTAssertEqual(storedPlayers.count, 1)
        XCTAssertTrue(
            storedPlayers.contains(sut.selectedPlayer)
        )
    }
    
    // MARK: - Helpers
    
    private func makeAppStorage(
        players: [Player] = []
    ) -> AppStorage {
        let storage = Mocks.storage
        players.forEach { storage.updatePlayer($0) }
        return storage
    }
    
    private func makeSUT(
        storage: PlayerStorageHandler = Mocks.storage,
        state: PlayerDetailsViewModel.State = .viewingDetails,
        player: Player = .init(name: "")
    ) -> PlayerDetailsViewModel {
        .init(
            storage: storage,
            state: state,
            player: player
        )
    }
    
}
