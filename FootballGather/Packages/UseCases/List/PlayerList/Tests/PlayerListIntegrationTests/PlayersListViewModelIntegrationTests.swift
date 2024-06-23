//
//  PlayersListViewModelIntegrationTests.swift
//  
//
//  Created by Radu Dan on 16.03.2022.
//

import XCTest
import FoundationMocks
import CoreModels
import SwiftUI
@testable import PlayerList

final class PlayersListViewModelIntegrationTests: XCTestCase {
    
    private let players = Player.demoPlayers
    
    override func tearDown() {
        Mocks.storage.clear()
        super.tearDown()
    }
    
    func testDeletePlayers() {
        let sut = makeSUT()
        
        players.forEach { player in
            sut.delete(player)
        }
        
        XCTAssertTrue(sut.players.isEmpty)
        XCTAssertTrue(Mocks.storage.storedPlayers.isEmpty)
    }
    
    @MainActor
    func testDeletePlayers_updatesShowListViewBinding() {
        var showListView = false
        let showListViewBinding = Binding<Bool>(
            get: { showListView },
            set: { showListView = $0 }
        )
        let sut = makeSUT(showListView: showListViewBinding)
        
        players.forEach { player in
            sut.delete(player)
        }
        
        XCTAssertTrue(sut.players.isEmpty)
        XCTAssertFalse(sut.showListView)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        showListView: Binding<Bool> = .constant(false)
    ) -> PlayersListViewModel {
        let storage = Mocks.storage
        
        players.forEach { player in
            storage.updatePlayer(player)
        }

        return .init(
            storage: storage,
            showListView: showListView
        )
    }
}
