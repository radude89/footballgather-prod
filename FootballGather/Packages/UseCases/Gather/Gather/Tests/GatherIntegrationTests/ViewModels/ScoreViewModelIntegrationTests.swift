//
//  ScoreViewModelIntegrationTests.swift
//  
//
//  Created by Radu Dan on 22.03.2022.
//

import XCTest
import CoreModels
import FoundationTools
@testable import Gather

@MainActor
final class ScoreViewModelIntegrationTests: XCTestCase {
    
    private static let maxScore = GatherMaxScore.value()
    private let teams: [Team] = [.teamA, .teamB]
    
    func testIncrementsScore() {
        var scoreHandler = ScoreHandler(
            score: [
                .teamA: Int.random(in: 0...Self.maxScore),
                .teamB: Int.random(in: 0...Self.maxScore)
            ]
        )
        let sut = ScoreViewModel(scoreHandler: scoreHandler)
        
        teams.forEach { team in
            sut.onIncrementScore(for: team)
            scoreHandler.incrementScore(for: team)
            
            XCTAssertEqual(
                sut.formattedScore(for: team),
                "\(scoreHandler.score(for: team))"
            )
        }
    }
    
    func testIncrementsScore_forBench_breaks() {
        let score = Int.random(in: 1..<Self.maxScore)
        let scoreHandler = ScoreHandler(
            score: [
                .teamA: score,
                .teamB: score
            ]
        )
        let sut = ScoreViewModel(scoreHandler: scoreHandler)
        
        sut.onIncrementScore(for: .bench)
        
        XCTAssertEqual(
            sut.teamAScore, scoreHandler.score(for: .teamA)
        )
        XCTAssertEqual(
            sut.teamBScore, scoreHandler.score(for: .teamB)
        )
    }
    
    func testDecrementsScore() {
        var scoreHandler = ScoreHandler(
            score: [
                .teamA: Int.random(in: 0...Self.maxScore),
                .teamB: Int.random(in: 0...Self.maxScore)
            ]
        )
        let sut = ScoreViewModel(scoreHandler: scoreHandler)
        
        teams.forEach { team in
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
        let scoreHandler = ScoreHandler(
            score: [
                .teamA: score,
                .teamB: score
            ]
        )
        let sut = ScoreViewModel(scoreHandler: scoreHandler)
        
        sut.onDecrementScore(for: .bench)
        
        XCTAssertEqual(
            sut.teamAScore, scoreHandler.score(for: .teamA)
        )
        XCTAssertEqual(
            sut.teamBScore, scoreHandler.score(for: .teamB)
        )
    }
    
}
