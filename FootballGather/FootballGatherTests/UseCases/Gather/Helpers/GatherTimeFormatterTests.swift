//
//  GatherTimeFormatterTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 13.12.2021.
//

import XCTest
@testable import FootballGather

final class GatherTimeFormatterTests: XCTestCase {
    
    private static let oneHourInSeconds = 60 * 60
        
    func testFormattedTime_whenSecondsAreBetweenOneAndNine_showsTimeInMMSSFormat() {
        (1...9).forEach { seconds in
            let sut = GatherTimeFormatter(seconds: seconds)
            XCTAssertEqual(sut.formattedTime, "00:0\(seconds)")
        }
    }
    
    func testFormattedTime_whenSecondsAreGreaterThanNineAndLessThanSixty_showsTimeInMMSSFormat() {
        (10...59).forEach { seconds in
            let sut = GatherTimeFormatter(seconds: seconds)
            XCTAssertEqual(sut.formattedTime, "00:\(seconds)")
        }
    }
    
    func testFormattedTime_whenTimeIsOneMinute_showsTimeInMMSSFormat() {
        let sut = GatherTimeFormatter(seconds: 60)
        XCTAssertEqual(sut.formattedTime, "01:00")
    }
    
    func testFormattedTime_whenTimeIsBetweenOneMinuteAndOneHour_showsTimeInMMSSFormat() {
        (60..<Self.oneHourInSeconds).forEach { seconds in
            let sut = GatherTimeFormatter(seconds: seconds)
            XCTAssertEqual(sut.formattedTime, expectedFormattedTime(for: seconds))
        }
    }
    
    func testFormattedTime_whenTimeIsOneHour_showsTimeInMMSSFormat() {
        let sut = GatherTimeFormatter(seconds: Self.oneHourInSeconds)
        XCTAssertEqual(sut.formattedTime, "60:00")
    }
    
    func testFormattedTime_whenSecondsAreGreaterThanAllowedTime_showsAllowedMaxTime() {
        let seconds = Int.random(in: 6_000...100_000)
        let sut = GatherTimeFormatter(seconds: seconds)
        XCTAssertEqual(sut.formattedTime, "99:59")
    }
    
    // MARK: - Helpers
    
    private func expectedFormattedTime(for seconds: Int) -> String {
        let expectedMinutes = seconds / 60
        let expectedSeconds = seconds % 60
        let expectedFormattedSeconds = expectedSeconds < 10 ? "0\(expectedSeconds)" : "\(expectedSeconds)"
        let expectedFormattedMinutes = expectedMinutes < 10 ? "0\(expectedMinutes)" : "\(expectedMinutes)"
        return "\(expectedFormattedMinutes):\(expectedFormattedSeconds)"
    }
    
}
