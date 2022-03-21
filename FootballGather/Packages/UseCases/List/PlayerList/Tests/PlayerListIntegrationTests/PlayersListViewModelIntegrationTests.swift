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
    
    func testSelectedPlayers() {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.players, players)
        players.forEach { player in
            XCTAssertTrue(sut.hasSelected(player))
        }
        XCTAssertTrue(sut.shouldConfirmPlayers)
    }
    
    func testHasSelected_whenAllRowsAreSelected_isTrueForAllPlayers() {
        let players = Player.demoPlayers
        players.forEach { Mocks.storage.updatePlayer($0) }
        
        let selectedRows = Set<UUID>(players.map { $0.id })
        let sut = PlayersListViewModel(
            storage: Mocks.storage,
            selectedRows: .constant(selectedRows)
        )
        
        players.forEach { player in
            XCTAssertTrue(sut.hasSelected(player))
        }
    }
    
    func testDeletePlayers() {
        let sut = makeSUT()
        
        players.forEach { player in
            sut.delete(player)
        }
        
        XCTAssertTrue(sut.players.isEmpty)
        XCTAssertTrue(Mocks.storage.storedPlayers.isEmpty)
    }
    
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
        
        let ids = players.map { $0.id }
        
        return .init(
            storage: storage,
            selectedRows: .constant(Set(ids)),
            showListView: showListView
        )
    }
}
