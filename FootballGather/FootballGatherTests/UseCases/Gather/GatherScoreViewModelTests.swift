//
//  GatherScoreViewModelTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 02.12.2021.
//

import XCTest
import CoreModels
import FoundationTools
@testable import FootballGather

final class GatherScoreViewModelTests: XCTestCase {
    
    private static let maxScore = GatherMaxScore.computeValue()
    
    func testHeaderTitle() {
        let sut = GatherScoreViewModel()
        
        Team.allCases.forEach { team in
            XCTAssertEqual(sut.headerTitle(for: team), team.name.uppercased())
        }
    }
    
    func testShowsScore() {
        let sut = GatherScoreViewModel(scoreHandler: .init())
        
        XCTAssertEqual(sut.formattedScore(for: .teamA), "0")
        XCTAssertEqual(sut.formattedScore(for: .teamB), "0")
    }
    
    func testIncrementsScore() {
        var scoreHandler = GatherScoreHandler(
            score: [
                .teamA: Int.random(in: 0...Self.maxScore),
                .teamB: Int.random(in: 0...Self.maxScore)
            ]
        )
        let sut = GatherScoreViewModel(scoreHandler: scoreHandler)
        
        [Team.teamA, Team.teamB].forEach { team in
            sut.onIncrementScore(for: team)
            scoreHandler.incrementScore(for: team)
            
            XCTAssertEqual(
                sut.formattedScore(for: team),
                "\(scoreHandler.score(for: team))"
            )
        }
        
        XCTAssertEqual(sut.teamAScore, scoreHandler.score(for: .teamA))
        XCTAssertEqual(sut.teamBScore, scoreHandler.score(for: .teamB))
    }
    
    func testIncrementsScore_forBench_breaks() {
        let score = Int.random(in: 1..<Self.maxScore)
        let scoreHandler = GatherScoreHandler(
            score: [
                .teamA: score,
                .teamB: score
            ]
        )
        let sut = GatherScoreViewModel(scoreHandler: scoreHandler)
        
        sut.onIncrementScore(for: .bench)
        
        XCTAssertEqual(sut.teamAScore, score)
        XCTAssertEqual(sut.teamBScore, score)
    }
    
    func testDecrementsScore() {
        var scoreHandler = GatherScoreHandler(
            score: [
                .teamA: Int.random(in: 0...Self.maxScore),
                .teamB: Int.random(in: 0...Self.maxScore)
            ]
        )
        let sut = GatherScoreViewModel(scoreHandler: scoreHandler)
        
        [Team.teamA, Team.teamB].forEach { team in
            sut.onDecrementScore(for: team)
            scoreHandler.decrementScore(for: team)
            
            XCTAssertEqual(
                sut.formattedScore(for: team),
                "\(scoreHandler.score(for: team))"
            )
        }
    }
    
    func testDecrementsScore_forBench_breaks() {
        let score = Int.random(in: 1..<Self.maxScore)
        let scoreHandler = GatherScoreHandler(
            score: [
                .teamA: score,
                .teamB: score
            ]
        )
        let sut = GatherScoreViewModel(scoreHandler: scoreHandler)
        
        sut.onDecrementScore(for: .bench)
        
        XCTAssertEqual(sut.teamAScore, score)
        XCTAssertEqual(sut.teamBScore, score)
    }
    
}
