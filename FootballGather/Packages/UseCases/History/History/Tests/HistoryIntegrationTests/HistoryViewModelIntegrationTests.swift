//
//  HistoryViewModelIntegrationTests.swift
//  
//
//  Created by Radu Dan on 15.03.2022.
//

import XCTest
import CoreModels
import FoundationTools
import FoundationMocks
@testable import History

final class HistoryViewModelIntegrationTests: XCTestCase {
    
    override func tearDown() {
        Mocks.storage.clear()
        super.tearDown()
    }
        
    func testSortGathers() {
        let storage = makePopulatedStorage()
        let sut = HistoryViewModel(storage: storage)
        
        let gathers = sut.gathers
        
        XCTAssertTrue(gathers[0].completedAt > gathers[1].completedAt)
    }
    
    func testHasGathers_whenStorageIsNotEmpty_hasGathers() {
        XCTAssertTrue(makeSUT().hasGathers)
    }
    
    func testHasGathers_whenGathersAreEmpty_isFalse() {
        XCTAssertFalse(makeSUT(gathers: []).hasGathers)
    }
    
    func testHasGathers_whenGathersAreNotEmpty_isTrue() {
        XCTAssertTrue(makeSUT().hasGathers)
    }
    
    func testScoreDescription_whenHasEntries_returnsGatherScore() {
        let gathers = Gather.demoGathers
        let sut = makeSUT(gathers: gathers)

        gathers.forEach { gather in
            XCTAssertEqual(sut.scoreDescription(for: gather), gather.score)
        }
    }
    
    func testAccessibilityLabel_isNotEmpty() {
        let gathers = Gather.demoGathers
        let sut = makeSUT(gathers: gathers)

        gathers.forEach { gather in
            let accessibilityLabel = sut.accessibilityLabel(for: gather)
            XCTAssertFalse(accessibilityLabel.isEmpty)
        }
    }
    
    func testTeamAPlayersDescription_whenHasEntries_isPlayerNamesJoinedByComma() {
        let gathers = Gather.demoGathers
        let sut = makeSUT(gathers: gathers)

        gathers.forEach { gather in
            let expectedDescription = Player.demoPlayers
                .map { $0.name }
                .joined(separator: ", ")
            
            XCTAssertEqual(
                sut.teamAPlayersDescription(for: gather),
                expectedDescription
            )
        }
    }
    
    func testTeamBPlayersDescription_whenHasEntries_isPlayerNamesJoinedByComma() {
        let gathers = Gather.demoGathers
        let sut = makeSUT(gathers: gathers)

        gathers.forEach { gather in
            let expectedDescription = Player.demoPlayers
                .map { $0.name }
                .joined(separator: ", ")
            
            XCTAssertEqual(
                sut.teamBPlayersDescription(for: gather),
                expectedDescription
            )
        }
    }
    
    func testGathers_areOrderedByDate() {
        let firstGatherDate = Date()
        var components = DateComponents()
        components.day = 1
        let secondGatherDate = Calendar.current.date(byAdding: components, to: firstGatherDate)!
        
        let firstGather = makeGather(completedAt: firstGatherDate)
        let secondGather = makeGather(completedAt: secondGatherDate)
        
        let sut = makeSUT(gathers: [firstGather, secondGather])
        
        XCTAssertEqual(sut.gathers, [secondGather, firstGather])
    }
    
    // MARK: - Helpers
    
    private func makeSUT(gathers: [Gather] = .demoGathers) -> HistoryViewModel {
        let storage = Mocks.storage
        gathers.forEach { storage.addGather($0) }
        return HistoryViewModel(storage: storage)
    }
    
    private func makePopulatedStorage() -> AppStorage {
        let storage = Mocks.storage
        let now = Date()
        let tomorrow = Calendar.current
            .date(byAdding: .day, value: 1, to: now)
        storage.addGather(makeGather(completedAt: now))
        storage.addGather(makeGather(completedAt: tomorrow!))
        return storage
    }
    
    private func makeGather(
        completedAt: Date,
        score: String = "0-0"
    ) -> Gather {
        .init(
            completedAt: completedAt,
            score: score,
            teamAPlayers: [],
            teamBPlayers: []
        )
    }
    
}
