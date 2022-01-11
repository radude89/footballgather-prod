//
//  TimeSettingsTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 11.01.2022.
//

import XCTest
import FoundationTools
@testable import FootballGather

final class TimeSettingsTests: XCTestCase {
    
    func testRemainingTimeInSeconds_initialValue() {
        XCTAssertEqual(
            TimeSettings().remainingTimeInSeconds,
            GatherDefaultTime.value()
        )
    }
    
    func testRemainingTimeInSeconds_publishesValue() {
        let sut = TimeSettings()
        let spy = Mocks.ValueSpy(
            sut.$remainingTimeInSeconds.eraseToAnyPublisher()
        )
        let newValue = 100
        
        sut.remainingTimeInSeconds = newValue
        
        XCTAssertEqual(
            spy.values, [GatherDefaultTime.value(), 100]
        )
    }
    
}
