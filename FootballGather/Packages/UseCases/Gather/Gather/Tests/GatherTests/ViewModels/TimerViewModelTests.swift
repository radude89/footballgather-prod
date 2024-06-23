//
//  TimerViewModelTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 09.12.2021.
//

import XCTest
import Combine
import GatherAssets
@testable import Gather

final class TimerViewModelTests: XCTestCase {
    
    func testOnActionTimer_timerStarted() {
        let timerController = Mocks.TimerController()
        let sut = makeSUT(timerController: timerController)
        
        sut.onActionTimer()
        
        XCTAssertTrue(timerController.timerStarted)
    }
    
    func testOnActionTimer_decrementsRemainingTime() {
        let timerController = Mocks.TimerController(remainingTimeUnit: 2)
        let sut = makeSUT(
            timerController: timerController,
            timeSettings: makeTimeSettings(remainingTimeInSeconds: 2)
        )
        let spy = Mocks.ValueSpy(sut.$formattedTime.eraseToAnyPublisher())
        
        sut.onActionTimer()
        
        XCTAssertEqual(spy.values, ["00:02", "00:01", "00:00", "00:02"])
    }
    
    func testOnActionTimer_stopsTimerAfterReachingToZero() {
        let timerController = Mocks.TimerController()
        let sut = makeSUT(
            timerController: timerController,
            timeSettings: makeTimeSettings(remainingTimeInSeconds: 1)
        )
        
        sut.onActionTimer()
        
        XCTAssertTrue(timerController.timerStopped)
        XCTAssertTrue(sut.timeIsUp)
    }
    
    func testCancelTimer_resetsTimeToInitial() {
        let timerController = Mocks.TimerController()
        let sut = makeSUT(
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
        let sut = makeSUT()
        
        sut.onActionTimer()
        
        XCTAssertTrue(sut.timerIsRunning)
    }
    
    func testTimerIsRunning_whenStateIsPaused_isFalse() {
        let sut = makeSUT()
        
        sut.onActionTimer()
        sut.onActionTimer()
        
        XCTAssertFalse(sut.timerIsRunning)
    }
    
    func testTimerIsRunning_whenStateIsStopped_isFalse() {
        XCTAssertFalse(makeSUT().timerIsRunning)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        timerController: Mocks.TimerController = .init(),
        timeSettings: TimeSettings = .init()
    ) -> TimerViewModel {
        let center = Mocks.NotificationCenter(
            authorizationStatus: .authorized
        )
        let scheduler = NotificationScheduler(center: center)
        let granter = Mocks.NotificationPermissionGranter(
            hasGrantedPermissions: true
        )
        let dispatcher = FakeDispatcher()
        
        return TimerViewModel(
            timerController: timerController,
            timeSettings: timeSettings,
            notificationPermissionGranter: granter,
            notificationScheduler: scheduler,
            timerUpdateDispatcher: dispatcher
        )
    }
    
    private func makeTimeSettings(remainingTimeInSeconds: Int) -> TimeSettings {
        let settings = TimeSettings()
        settings.remainingTimeInSeconds = remainingTimeInSeconds
        return settings
    }
    
}
