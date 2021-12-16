//
//  TimerViewModelTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 09.12.2021.
//

import XCTest
import Combine
import Localizable
@testable import FootballGather

final class TimerViewModelTests: XCTestCase {
    
    func testStartTimer() {
        let timerController = Mocks.TimerController()
        let sut = TimerViewModel(timerController: timerController)
        
        sut.startTimer()
        
        XCTAssertTrue(timerController.timerStarted)
    }
    
    func testStartTime_decrementsRemainingTime() {
        let timerController = Mocks.TimerController(remainingTimeUnit: 2)
        let sut = TimerViewModel(
            timerController: timerController,
            remainingTimeInSeconds: 2
        )
        let spy = ValueSpy(sut.$formattedTime.eraseToAnyPublisher())
        
        sut.startTimer()
        
        XCTAssertEqual(spy.values, ["00:02", "00:01", "00:00"])
    }
    
    func testStartTimer_stopsTimerAfterReachingToZero() {
        let timerController = Mocks.TimerController()
        let sut = TimerViewModel(timerController: timerController, remainingTimeInSeconds: 1)
        
        sut.startTimer()
        
        XCTAssertTrue(timerController.timerStopped)
    }
    
    func testCancelTimer_resetsTimeToInitial() {
        let timerController = Mocks.TimerController()
        let sut = TimerViewModel(
            timerController: timerController,
            remainingTimeInSeconds: 1
        )
        let spy = ValueSpy(sut.$formattedTime.eraseToAnyPublisher())
        
        sut.startTimer()
        sut.cancelTimer()
        sut.startTimer()
        
        XCTAssertEqual(spy.values, ["00:01", "00:00", "00:01", "00:00"])
        XCTAssertTrue(timerController.timerStopped)
    }
    
}

// MARK: - Helpers

private final class ValueSpy<Value> {
    private(set) var values: [Value] = []
    private var cancellable: AnyCancellable?
    
    init(_ publisher: AnyPublisher<Value, Never>) {
        cancellable = publisher.sink(receiveValue: { [weak self] value in
            self?.values.append(value)
        })
    }
}
