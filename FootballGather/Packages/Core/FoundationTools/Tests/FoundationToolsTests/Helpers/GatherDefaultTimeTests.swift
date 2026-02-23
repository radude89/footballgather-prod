//
//  GatherDefaultTimeTests.swift
//  
//
//  Created by Radu Dan on 13.12.2021.
//

import XCTest
@testable import FoundationTools

final class GatherDefaultTimeTests: XCTestCase {
    
    func testDefaultTime_whenIsNotRunningUITests_isTenMinutes() {
        let expectedTimeInSeconds = 10 * 60
        let sut = GatherDefaultTime.value(isRunningUITests: false)
        
        XCTAssertEqual(sut, expectedTimeInSeconds)
    }
    
    func testDefaultTime_whenIsRunningUITests_isTwoSeconds() {
        let expectedTimeInSeconds = GatherDefaultTime.inSecondsWhenIsRunningUITests
        let sut = GatherDefaultTime.value(isRunningUITests: true)
        
        XCTAssertEqual(sut, expectedTimeInSeconds)
    }
    
    func testMinAllowedTimeInSeconds() {
        XCTAssertEqual(GatherDefaultTime.minAllowedTimeInSeconds, 1)
    }
    
}
