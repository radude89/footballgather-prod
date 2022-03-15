//
//  TimerSceneChangeHandlerTests.swift
//  
//
//  Created by Radu Dan on 15.03.2022.
//

import XCTest
@testable import Gather

final class TimerSceneChangeHandlerTests: XCTestCase {
    
    func testOnScenePhaseChanged_toInactive_andTimerRunning_handlesScenePhase() async {
        let delegate = Mocks.TimerSceneChangeHandlerDelegate(
            timerIsRunning: true
        )
        let sut = TimerSceneChangeHandler(delegate: delegate)
        
        await sut.onScenePhaseChanged(to: .inactive)
        
        XCTAssertTrue(delegate.scheduleNotificationCalled)
        XCTAssertTrue(delegate.pauseTimerCalled)
    }
    
    func testOnScenePhaseChanged_toBackground_andTimerRunning_handlesScenePhase() async {
        let delegate = Mocks.TimerSceneChangeHandlerDelegate(
            timerIsRunning: true
        )
        let sut = TimerSceneChangeHandler(delegate: delegate)
        
        await sut.onScenePhaseChanged(to: .background)
        
        XCTAssertTrue(delegate.scheduleNotificationCalled)
        XCTAssertTrue(delegate.pauseTimerCalled)
    }
    
    func testOnScenePhaseChanged_toInactive_andTimerIsNotRunning_returns() async {
        let delegate = Mocks.TimerSceneChangeHandlerDelegate(
            timerIsRunning: false
        )
        let sut = TimerSceneChangeHandler(delegate: delegate)
        
        await sut.onScenePhaseChanged(to: .inactive)
        
        XCTAssertFalse(delegate.scheduleNotificationCalled)
    }
    
    func testOnScenePhaseChanged_toBackground_andTimerIsNotRunning_returns() async {
        let delegate = Mocks.TimerSceneChangeHandlerDelegate(
            timerIsRunning: false
        )
        let sut = TimerSceneChangeHandler(delegate: delegate)
        
        await sut.onScenePhaseChanged(to: .background)
        
        XCTAssertFalse(delegate.scheduleNotificationCalled)
    }
    
    func testOnScenePhaseChanged_toActive_andHasStartedCounting_callsDelegate() async {
        let delegate = Mocks.TimerSceneChangeHandlerDelegate(
            timerIsRunning: true,
            remainingTimeInSeconds: 1
        )
        let sut = TimerSceneChangeHandler(delegate: delegate)
        await sut.onScenePhaseChanged(to: .background)
        
        await sut.onScenePhaseChanged(to: .active)
        
        XCTAssertTrue(delegate.cancelNotificationsCalled)
        XCTAssertTrue(delegate.updateRemainingTimeCalled)
        XCTAssertFalse(delegate.timerReachedZeroCalled)
        XCTAssertTrue(delegate.startTimerCalled)
    }
    
    func testOnScenePhaseChanged_toActive_andHasStartedCountingAndRemainingTimeIsZero_callsTimerReachedZero() async {
        let delegate = Mocks.TimerSceneChangeHandlerDelegate(
            timerIsRunning: true,
            remainingTimeInSeconds: 0
        )
        let sut = TimerSceneChangeHandler(delegate: delegate)
        await sut.onScenePhaseChanged(to: .background)
        
        await sut.onScenePhaseChanged(to: .active)
        
        XCTAssertTrue(delegate.cancelNotificationsCalled)
        XCTAssertTrue(delegate.updateRemainingTimeCalled)
        XCTAssertTrue(delegate.timerReachedZeroCalled)
        XCTAssertFalse(delegate.startTimerCalled)
    }
    
    func testOnScenePhaseChanged_toActive_andHasNotStartedCounting_returns() async {
        let delegate = Mocks.TimerSceneChangeHandlerDelegate()
        let sut = TimerSceneChangeHandler(delegate: delegate)
        
        await sut.onScenePhaseChanged(to: .active)
        
        XCTAssertFalse(delegate.cancelNotificationsCalled)
        XCTAssertFalse(delegate.updateRemainingTimeCalled)
        XCTAssertFalse(delegate.timerReachedZeroCalled)
        XCTAssertFalse(delegate.startTimerCalled)
    }
    
}
