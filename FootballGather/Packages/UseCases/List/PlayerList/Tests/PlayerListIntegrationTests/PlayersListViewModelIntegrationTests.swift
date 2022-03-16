//
//  PlayersListViewModelIntegrationTests.swift
//  
//
//  Created by Radu Dan on 16.03.2022.
//

import XCTest
import FoundationMocks
import CoreModels
@testable import PlayerList

final class PlayersListViewModelIntegrationTests: XCTestCase {
    
    private let players = Player.demoPlayers
    
    override func tearDown() {
        Mocks.storage.clear()
        super.tearDown()
    }
    
    func testSelectedPlayers() {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.players, players)
        players.forEach { player in
            XCTAssertTrue(sut.hasSelected(player))
        }
        XCTAssertTrue(sut.shouldConfirmPlayers)
    }
    
    func testDeletePlayers() {
        let sut = makeSUT()
        
        players.forEach { player in
            sut.delete(player)
        }
        
        XCTAssertTrue(sut.players.isEmpty)
        XCTAssertTrue(Mocks.storage.storedPlayers.isEmpty)
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> PlayersListViewModel {
        let storage = Mocks.storage
        
        players.forEach { player in
            storage.updatePlayer(player)
        }
        
        let ids = players.map { $0.id }
        
        return .init(
            storage: storage,
            selectedRows: .constant(Set(ids))
        )
    }
}
