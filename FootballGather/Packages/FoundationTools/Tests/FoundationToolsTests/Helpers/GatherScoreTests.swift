//
//  GatherScoreTests.swift
//  
//
//  Created by Radu Dan on 01.12.2021.
//

import XCTest
@testable import FoundationTools

final class GatherScoreTests: XCTestCase {
    
    func testMaxScore() {
        XCTAssertEqual(GatherScore.maxValue, 99)
    }
    
}
