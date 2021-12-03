//
//  GatherMaxScoreTests.swift
//  
//
//  Created by Radu Dan on 01.12.2021.
//

import XCTest
@testable import FoundationTools

final class GatherMaxScoreTests: XCTestCase {
    
    func testMaxScore_whenIsRunningUITests() {
        let maxScore = GatherMaxScore.computeValue(isRunningUITests: true)
        XCTAssertEqual(maxScore, 3)
    }
    
    func testMaxScore_whenIsNotRunningUITests() {
        let maxScore = GatherMaxScore.computeValue(isRunningUITests: false)
        XCTAssertEqual(maxScore, 99)
    }
    
}
