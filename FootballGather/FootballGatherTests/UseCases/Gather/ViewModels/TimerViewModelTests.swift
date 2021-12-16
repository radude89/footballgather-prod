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
    
    func testOnActionTimer_timerStarted() {
        let timerController = Mocks.TimerController()
        let sut = TimerViewModel(timerController: timerController)
        
        sut.onActionTimer()
        
        XCTAssertTrue(timerController.timerStarted)
    }
    
    func testOnActionTimer_decrementsRemainingTime() {
        let timerController = Mocks.TimerController(remainingTimeUnit: 2)
        let sut = TimerViewModel(
            timerController: timerController,
            remainingTimeInSeconds: 2
        )
        let spy = ValueSpy(sut.$formattedTime.eraseToAnyPublisher())
        
        sut.onActionTimer()
        
        XCTAssertEqual(spy.values, ["00:02", "00:01", "00:00"])
    }
    
    func testOnActionTimer_stopsTimerAfterReachingToZero() {
        let timerController = Mocks.TimerController()
        let sut = TimerViewModel(timerController: timerController, remainingTimeInSeconds: 1)
        
        sut.onActionTimer()
        
        XCTAssertTrue(timerController.timerStopped)
    }
    
    func testCancelTimer_resetsTimeToInitial() {
        let timerController = Mocks.TimerController()
        let sut = TimerViewModel(
            timerController: timerController,
            remainingTimeInSeconds: 1
        )
        let spy = ValueSpy(sut.$formattedTime.eraseToAnyPublisher())
        
        sut.onActionTimer()
        sut.cancelTimer()
        sut.onActionTimer()
        
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
