//
//  TimerViewModelTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 09.12.2021.
//

import XCTest
import Combine
import Localizable
@testable import Gather

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
            timeSettings: makeTimeSettings(remainingTimeInSeconds: 2)
        )
        let spy = Mocks.ValueSpy(sut.$formattedTime.eraseToAnyPublisher())
        
        sut.onActionTimer()
        
        XCTAssertEqual(spy.values, ["00:02", "00:01", "00:00", "00:02"])
    }
    
    func testOnActionTimer_stopsTimerAfterReachingToZero() {
        let timerController = Mocks.TimerController()
        let sut = TimerViewModel(
            timerController: timerController,
            timeSettings: makeTimeSettings(remainingTimeInSeconds: 1)
        )
        
        sut.onActionTimer()
        
        XCTAssertTrue(timerController.timerStopped)
        XCTAssertTrue(sut.timeIsUp)
    }
    
    func testCancelTimer_resetsTimeToInitial() {
        let timerController = Mocks.TimerController()
        let sut = TimerViewModel(
            timerController: timerController,
            timeSettings: makeTimeSettings(remainingTimeInSeconds: 1)
        )
        let spy = Mocks.ValueSpy(sut.$formattedTime.eraseToAnyPublisher())
        
        sut.onActionTimer()
        sut.cancelTimer()
        sut.onActionTimer()
        
        XCTAssertEqual(spy.values, ["00:01", "00:00", "00:01", "00:01", "00:00", "00:01"])
        XCTAssertTrue(timerController.timerStopped)
    }
    
    func testTimerIsRunning_whenStateIsStarted_isTrue() {
        let timerController = Mocks.TimerController()
        let sut = TimerViewModel(timerController: timerController)
        
        sut.onActionTimer()
        
        XCTAssertTrue(sut.timerIsRunning)
    }
    
    func testTimerIsRunning_whenStateIsPaused_isFalse() {
        let timerController = Mocks.TimerController()
        let sut = TimerViewModel(timerController: timerController)
        
        sut.onActionTimer()
        sut.onActionTimer()
        
        XCTAssertFalse(sut.timerIsRunning)
    }
    
    func testTimerIsRunning_whenStateIsStopped_isFalse() {
        let timerController = Mocks.TimerController()
        let sut = TimerViewModel(timerController: timerController)
        
        XCTAssertFalse(sut.timerIsRunning)
    }
    
    // MARK: - Helpers
    
    private func makeTimeSettings(remainingTimeInSeconds: Int) -> TimeSettings {
        let settings = TimeSettings()
        settings.remainingTimeInSeconds = remainingTimeInSeconds
        return settings
    }
    
}
