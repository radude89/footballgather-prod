//
//  HistoryViewModelTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 13.01.2022.
//

import XCTest
import CoreModels
import FoundationTools
@testable import History

final class HistoryViewModelTests: XCTestCase {
    
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
        
        let firstGather = makeGather(date: firstGatherDate)
        let secondGather = makeGather(date: secondGatherDate)
        
        let sut = makeSUT(gathers: [firstGather, secondGather])
        
        XCTAssertEqual(sut.gathers, [secondGather, firstGather])
    }
    
    // MARK: - Helpers
    
    private final class MockGatherStorageHandler: GatherStorageHandler {
        
        private(set) var gathers: [Gather]
        private(set) var addGatherCalled = false
        
        init(gathers: [Gather] = []) {
            self.gathers = gathers
        }
        
        func addGather(_ gather: Gather) {
            addGatherCalled = true
        }
        
    }
    
    private func makeSUT(gathers: [Gather] = .demoGathers) -> HistoryViewModel {
        .init(storage: MockGatherStorageHandler(gathers: gathers))
    }
    
    private func makeGather(
        score: String = "0-0",
        date: Date = .init()
    ) -> Gather {
        .init(
            completedAt: date,
            score: score,
            teamAPlayers: .demoPlayers,
            teamBPlayers: .demoPlayers
        )
    }
    
}
