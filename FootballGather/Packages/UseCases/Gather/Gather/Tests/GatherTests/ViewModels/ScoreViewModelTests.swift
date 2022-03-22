//
//  ScoreViewModelTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 02.12.2021.
//

import XCTest
import CoreModels
import FoundationTools
@testable import Gather

final class ScoreViewModelTests: XCTestCase {
    
    private static let maxScore = GatherMaxScore.value()
    
    func testHeaderTitle() {
        let sut = ScoreViewModel()
        
        Team.allCases.forEach { team in
            XCTAssertEqual(sut.headerTitle(for: team), team.name.uppercased())
        }
    }
    
    func testShowsScore() {
        let sut = ScoreViewModel()
        
        XCTAssertEqual(sut.formattedScore(for: .teamA), "0")
        XCTAssertEqual(sut.formattedScore(for: .teamB), "0")
    }
    
    func testFormattedScore() {
        let sut = ScoreViewModel()
        
        XCTAssertEqual(sut.formattedScore, "0:0")
    }
    
    func testScoreViewAccessibilityLabel_containsScoreAndTeam() {
        let sut = ScoreViewModel()
        
        [Team.teamA, Team.teamB].forEach { team in
            let accessibilityLabel = sut.scoreViewAccessibilityLabel(
                for: team
            )
            
            let score = sut.formattedScore(for: team)
            XCTAssertTrue(accessibilityLabel.contains(score))
            XCTAssertTrue(accessibilityLabel.contains(team.name))
        }
    }
    
    func testIncrementsScore() {
        let sut = ScoreViewModel()
        
        sut.onIncrementScore(for: .teamA)
        sut.onIncrementScore(for: .teamB)
        
        XCTAssertEqual(sut.teamAScore, 1)
        XCTAssertEqual(sut.teamBScore, 1)
    }
    
    func testIncrementsScore_forBench_breaks() {
        let sut = ScoreViewModel()
        
        sut.onIncrementScore(for: .bench)
        
        XCTAssertEqual(sut.teamAScore, 0)
        XCTAssertEqual(sut.teamBScore, 0)
    }
    
    func testDecrementsScore() {
        let scoreHandler = MockScoreHandler()
        let sut = ScoreViewModel(scoreHandler: scoreHandler)
        
        sut.onDecrementScore(for: .teamA)
        sut.onDecrementScore(for: .teamB)
        
        XCTAssertTrue(scoreHandler.decrementScoreCalled)
    }
    
    func testDecrementsScore_forBench_breaks() {
        let sut = ScoreViewModel()
        
        sut.onDecrementScore(for: .bench)
        
        XCTAssertEqual(sut.teamAScore, 0)
        XCTAssertEqual(sut.teamBScore, 0)
    }
    
    // MARK: - Helpers
    
    private final class MockScoreHandler: ScoreHandling {
        
        private(set) var incrementScoreCalled = false
        private(set) var decrementScoreCalled = false
        
        func score(for team: Team) -> Int {
            0
        }
        
        func incrementScore(for team: Team) {
            incrementScoreCalled = true
        }
        
        func decrementScore(for team: Team) {
            decrementScoreCalled = true
        }
        
    }
    
}
