//
//  PlayersViewModelIntegrationTests.swift
//  
//
//  Created by Radu Dan on 16.03.2022.
//

import XCTest
import FoundationMocks
import CoreModels
@testable import PlayerList

final class PlayersViewModelIntegrationTests: XCTestCase {
    
    private let players = Player.demoPlayers
    
    override func tearDown() {
        Mocks.storage.clear()
        super.tearDown()
    }
    
    func testStoredPlayers() {
        let sut = makeSUT()
        
        XCTAssertTrue(sut.hasPlayers)
        XCTAssertEqual(sut.storedPlayers, players)
    }
    
    // MARK: - Helpers
    
    private func makeSUT() -> PlayersViewModel {
        let storage = Mocks.storage
        
        players.forEach { player in
            storage.updatePlayer(player)
        }
        
        return .init(
            storage: storage
        )
    }
    
}
