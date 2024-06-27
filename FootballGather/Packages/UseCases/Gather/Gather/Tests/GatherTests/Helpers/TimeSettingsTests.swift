//
//  TimeSettingsTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 11.01.2022.
//

import XCTest
import FoundationTools
@testable import Gather

final class TimeSettingsTests: XCTestCase {
    
    func testRemainingTimeInSeconds_initialValue() {
        XCTAssertEqual(
            TimeSettings().remainingTimeInSeconds,
            GatherDefaultTime.value()
        )
    }
    
    func testRemainingTimeInSeconds_publishesValue() {
        let expectation = XCTestExpectation(description: "Waiting for `remainingTimeInSeconds` updates expectation.")
        let updatedValues = [GatherDefaultTime.value(), 100]
        var collectedValues: [Int] = []
        let sut = TimeSettings { remainingTimeInSeconds in
            collectedValues.append(remainingTimeInSeconds)
            if collectedValues == updatedValues {
                expectation.fulfill()
            }
        }
        
        updatedValues.forEach { sut.remainingTimeInSeconds = $0 }
        
        wait(for: [expectation], timeout: 2)
    }
    
}
