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
        let sut = makeSUT()
        
        sut.onActionTimer()
        
        XCTAssertTrue(sut.cancelButtonIsEnabled)
    }
    
    func testCancelButtonTitle_whenTimerPaused_isEnabled() {
        let sut = makeSUT()
        
        sut.onActionTimer()
        sut.onActionTimer()
        
        XCTAssertTrue(sut.cancelButtonIsEnabled)
    }
    
    func testActionTimerButtonTitle_whenTimerIsStopped_isStart() {
        XCTAssertEqual(makeSUT().actionButtonTitle, LocalizedString.start)
    }
    
    func testActionTimerButtonTitle_whenTimerIsStarted_isPause() {
        let sut = makeSUT()
        
        sut.onActionTimer()
        
        XCTAssertEqual(sut.actionButtonTitle, LocalizedString.pause)
    }
    
    func testActionTimerButtonTitle_whenTimerIsPaused_isResume() {
        let sut = makeSUT()
        
        sut.onActionTimer()
        sut.onActionTimer()
        
        XCTAssertEqual(sut.actionButtonTitle, LocalizedString.resume)
    }
    
    func testActionTimerButtonAccessibilityLabel_whenTimerIsStopped_isStartTimerLabel() {
        XCTAssertEqual(
            makeSUT().actionButtonAccessibilityLabel,
            LocalizedString.startTimerLabel
        )
    }
    
    func testActionTimerButtonAccessibilityLabel_whenTimerIsStarted_isPauseTimerLabel() {
        let sut = makeSUT()
        
        sut.onActionTimer()
        
        XCTAssertEqual(
            sut.actionButtonAccessibilityLabel,
            LocalizedString.pauseTimerLabel
        )
    }
    
    func testActionTimerButtonAccessibilityLabel_whenTimerIsPaused_isResumeTimerLabel() {
        let sut = makeSUT()
        
        sut.onActionTimer()
        sut.onActionTimer()
        
        XCTAssertEqual(
            sut.actionButtonAccessibilityLabel,
            LocalizedString.resumeTimerLabel
        )
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        timerController: TimerControllable = Mocks.TimerController(),
        remainingTimeInSeconds: Int = 2
    ) -> TimerViewModel {
        let settings = TimeSettings()
        settings.remainingTimeInSeconds = remainingTimeInSeconds
        
        return TimerViewModel(
            timerController: timerController,
            timeSettings: settings
        )
    }
    
}
