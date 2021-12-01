//
//  GatherScoreHandlerTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 01.12.2021.
//

import XCTest
import CoreModels
import FoundationTools
@testable import FootballGather

final class GatherScoreHandlerTests: XCTestCase {
    
    func testScore_isInitialZero() {
        let sut = GatherScoreHandler()
        
        XCTAssertEqual(sut.formattedScore(for: .teamA), "0")
        XCTAssertEqual(sut.formattedScore(for: .teamB), "0")
    }
    
    func testScore_whenIncrements_updatesScore() {
        var sut = GatherScoreHandler()
        
        sut.incrementScore(for: .teamA)
        sut.incrementScore(for: .teamB)
        
        XCTAssertEqual(sut.formattedScore(for: .teamA), "1")
        XCTAssertEqual(sut.formattedScore(for: .teamB), "1")
    }
    
    func testScore_whenCurrentScoreIsMaximumAndIcrements_keepsSameScore() {
        var sut = GatherScoreHandler(
            score: [
                .teamA: GatherScore.maxValue,
                .teamB: GatherScore.maxValue
            ]
        )
        
        sut.incrementScore(for: .teamA)
        sut.incrementScore(for: .teamB)
        
        XCTAssertEqual(sut.formattedScore(for: .teamA), "99")
        XCTAssertEqual(sut.formattedScore(for: .teamB), "99")
    }
    
    func testScore_whenDecrements_updatesScore() {
        var sut = GatherScoreHandler(
            score: [
                .teamA: 10,
                .teamB: 10
            ]
        )
        
        sut.decrementScore(for: .teamA)
        sut.decrementScore(for: .teamB)
        
        XCTAssertEqual(sut.formattedScore(for: .teamA), "9")
        XCTAssertEqual(sut.formattedScore(for: .teamB), "9")
    }
    
    func testScore_whenCurrentScoreIsZeroAndDecrements_scoreRemainsAtZero() {
        var sut = GatherScoreHandler()
        
        sut.decrementScore(for: .teamA)
        sut.decrementScore(for: .teamB)
        
        XCTAssertEqual(sut.formattedScore(for: .teamA), "0")
        XCTAssertEqual(sut.formattedScore(for: .teamB), "0")
    }
    
}
