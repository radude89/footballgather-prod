//
//  TimerViewModelTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 09.12.2021.
//

import XCTest
import Combine
@testable import FootballGather

final class TimerViewModelTests: XCTestCase {
    
    func testStartTimer() {
        let timerController = Mocks.TimerController()
        let sut = TimerViewModel(timerController: timerController)
        
        sut.startTimer()
        
        XCTAssertTrue(timerController.timerStarted)
    }
    
    func testStopTimer() {
        let timerController = Mocks.TimerController()
        let sut = TimerViewModel(timerController: timerController)
        
        sut.stopTimer()
        
        XCTAssertTrue(timerController.timerStopped)
    }
    
    func testStartTime_decrementsRemainingTime() {
        let timerController = Mocks.TimerController(remainingTimeUnit: 2)
        let sut = TimerViewModel(
            timerController: timerController,
            remainingTimeInSeconds: 2
        )
        let spy = ValueSpy(sut.$remainingTimeInSeconds.eraseToAnyPublisher())
        
        sut.startTimer()
        
        XCTAssertEqual(spy.values, [2, 1, 0])
    }
    
    func testStartTimer_stopsTimerAfterReachingToZero() {
        let timerController = Mocks.TimerController()
        let sut = TimerViewModel(timerController: timerController)
        
        sut.startTimer()
        
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
