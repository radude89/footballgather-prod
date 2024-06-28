//
//  SetTimerViewModelTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 22.12.2021.
//

import XCTest
import FoundationTools
@testable import Gather

final class SetTimerViewModelTests: XCTestCase {
    
    @MainActor
    func testFormattedMinutes_whenMinutesAreBelowTen_prefixesWithZero() {
        let minutes = Array(0...9)
        let sut = makeSUT(minutes: minutes)
        let formattedMinutes = minutes.map { "0\($0)" }
        
        XCTAssertEqual(sut.formattedMinutes, formattedMinutes)
    }
    
    @MainActor
    func testFormattedMinutes_whenMinutesIsTen_returnsFormattedTime() {
        let sut = makeSUT(minutes: [10])
        XCTAssertEqual(sut.formattedMinutes, ["10"])
    }
    
    @MainActor
    func testFormattedSeconds_whenSecondsAreBelowTen_prefixesWithZero() {
        let seconds = Array(0...9)
        let sut = makeSUT(seconds: seconds)
        let formattedSeconds = seconds.map { "0\($0)" }
        
        XCTAssertEqual(sut.formattedSeconds, formattedSeconds)
    }
    
    @MainActor
    func testFormattedSeconds_whenSecondsIsTen_returnsFormattedTime() {
        let sut = makeSUT(seconds: [10])
        XCTAssertEqual(sut.formattedSeconds, ["10"])
    }
    
    @MainActor
    func testDoneButtonIsEnabled_whenTimeIsNotChanged_isFalse() {
        let sut = makeSUT(selectedMinutes: "10", selectedSeconds: "00")
        XCTAssertFalse(sut.doneButtonIsEnabled(minutes: "10", seconds: "00"))
    }
    
    @MainActor
    func testDoneButtonIsEnabled_whenMinutesAreChanged_isTrue() {
        let sut = makeSUT(selectedMinutes: "10", selectedSeconds: "00")
        XCTAssertTrue(sut.doneButtonIsEnabled(minutes: "00", seconds: "00"))
    }
    
    @MainActor
    func testDoneButtonIsEnabled_whenSecondsAreChanged_isTrue() {
        let sut = makeSUT(selectedMinutes: "10", selectedSeconds: "00")
        XCTAssertTrue(sut.doneButtonIsEnabled(minutes: "10", seconds: "01"))
    }
    
    @MainActor
    func testDoneButtonIsEnabled_whenTimeIsChanged_isTrue() {
        let sut = makeSUT(selectedMinutes: "10", selectedSeconds: "00")
        XCTAssertTrue(sut.doneButtonIsEnabled(minutes: "01", seconds: "01"))
    }
    
    @MainActor
    func testRemainingTimeInSeconds_returnsTotalTimeInSeconds() {
        let sut = makeSUT()
        let time = sut.remainingTimeInSeconds(fromMinutes: "10", seconds: "10")
        
        XCTAssertEqual(time, 610)
    }
    
    @MainActor
    func testRemainingTimeInSeconds_whenMinutesAreNotFormattedAsInt_returnsZero() {
        let sut = makeSUT()
        let time = sut.remainingTimeInSeconds(fromMinutes: "", seconds: "00")
        
        XCTAssertEqual(time, 0)
    }
    
    @MainActor
    func testRemainingTimeInSeconds_whenMinutesAreBelowZero_returnsAbsolutValue() {
        let sut = makeSUT()
        let time = sut.remainingTimeInSeconds(fromMinutes: "-10", seconds: "00")
        
        XCTAssertEqual(time, 600)
    }
    
    @MainActor
    func testRemainingTimeInSeconds_whenSecondsAreNotFormattedAsInt_returnsZero() {
        let sut = makeSUT()
        let time = sut.remainingTimeInSeconds(fromMinutes: "00", seconds: "")
        
        XCTAssertEqual(time, 0)
    }
    
    @MainActor
    func testRemainingTimeInSeconds_whenSecondsAreBelowZero_returnsAbsolutValue() {
        let sut = makeSUT()
        let time = sut.remainingTimeInSeconds(fromMinutes: "00", seconds: "-15")
        
        XCTAssertEqual(time, 15)
    }
    
    @MainActor
    func testRemainingTimeInSeconds_whenTotalTimeIsLessThanMin_returnsMinTime() {
        let sut = makeSUT()
        let time = sut.remainingTimeInSeconds(fromMinutes: "00", seconds: "00")
        
        XCTAssertEqual(time, GatherDefaultTime.minAllowedTimeInSeconds)
    }
    
    // MARK: - Helpers
    
    @MainActor
    private func makeSUT(
        minutes: [Int] = [],
        seconds: [Int] = [],
        selectedMinutes: String = "",
        selectedSeconds: String = ""
    ) -> SetTimerViewModel {
        let timeIntervals = SetTimerViewModel.TimeIntervals(
            minutes: minutes,
            seconds: seconds
        )
        let sut = SetTimerViewModel(
            timeIntervals: timeIntervals,
            selectedMinutes: selectedMinutes,
            selectedSeconds: selectedSeconds
        )
        
        return sut
    }
    
}
