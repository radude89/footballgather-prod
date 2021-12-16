//
//  TimerViewModel+UIModelTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 16.12.2021.
//

import XCTest
import Localizable
@testable import FootballGather

final class TimerViewModelUIModelTests: XCTestCase {
    
    func testCancelButtonTitle_whenTimerIsStopped_isDisabled() {
        let sut = TimerViewModel()
        XCTAssertFalse(sut.cancelButtonIsEnabled)
    }
    
    func testCancelButtonTitle_whenTimerStarted_isEnabled() {
        let timerController = Mocks.TimerController()
        let sut = TimerViewModel(timerController: timerController)
        
        sut.onActionTimer()
        
        XCTAssertTrue(sut.cancelButtonIsEnabled)
    }
    
    func testCancelButtonTitle_whenTimerPaused_isEnabled() {
        let timerController = Mocks.TimerController()
        let sut = TimerViewModel(timerController: timerController)
        
        sut.onActionTimer()
        sut.onActionTimer()
        
        XCTAssertTrue(sut.cancelButtonIsEnabled)
    }
    
    func testActionTimerButtonTitle_whenTimerIsStopped_isStart() {
        let sut = TimerViewModel()
        XCTAssertEqual(sut.actionButtonTitle, LocalizedString.start)
    }
    
    func testActionTimerButtonTitle_whenTimerIsStarted_isPause() {
        let timerController = Mocks.TimerController()
        let sut = TimerViewModel(timerController: timerController)
        
        sut.onActionTimer()
        
        XCTAssertEqual(sut.actionButtonTitle, LocalizedString.pause)
    }
    
    func testActionTimerButtonTitle_whenTimerIsPaused_isResume() {
        let timerController = Mocks.TimerController()
        let sut = TimerViewModel(
            timerController: timerController,
            remainingTimeInSeconds: 2
        )
        
        sut.onActionTimer()
        sut.onActionTimer()
        
        XCTAssertEqual(sut.actionButtonTitle, LocalizedString.resume)
    }
    
    func testActionTimerButtonAccessibilityLabel_whenTimerIsStopped_isStartTimerLabel() {
        let sut = TimerViewModel()
        
        XCTAssertEqual(
            sut.actionButtonAccessibilityLabel,
            LocalizedString.startTimerLabel
        )
    }
    
    func testActionTimerButtonAccessibilityLabel_whenTimerIsStarted_isPauseTimerLabel() {
        let timerController = Mocks.TimerController()
        let sut = TimerViewModel(timerController: timerController)
        
        sut.onActionTimer()
        
        XCTAssertEqual(
            sut.actionButtonAccessibilityLabel,
            LocalizedString.pauseTimerLabel
        )
    }
    
    func testActionTimerButtonAccessibilityLabel_whenTimerIsPaused_isResumeTimerLabel() {
        let timerController = Mocks.TimerController()
        let sut = TimerViewModel(
            timerController: timerController,
            remainingTimeInSeconds: 2
        )
        
        sut.onActionTimer()
        sut.onActionTimer()
        
        XCTAssertEqual(
            sut.actionButtonAccessibilityLabel,
            LocalizedString.resumeTimerLabel
        )
    }
    
}
