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
    
    private let timerController = Mocks.TimerController()
    
    func testStartTimer() {
        let sut = TimerViewModel(timerController: timerController)
        
        sut.startTimer()
        
        XCTAssertTrue(timerController.timerStarted)
    }
    
    func testStopTimer() {
        let sut = TimerViewModel(timerController: timerController)
        
        sut.stopTimer()
        
        XCTAssertTrue(timerController.timerStopped)
    }
    
    func testStartTime_updatesDate() {
        
    }
    
}

final class TimerViewModel {
    private var timerController: TimerControllable
    
    init(timerController: TimerControllable = TimerController()) {
        self.timerController = timerController
    }
    
    func startTimer() {
        timerController.startTimer { _ in }
    }
    
    func stopTimer() {
        timerController.stopTimer()
    }
}

// MARK: - Helpers

extension Mocks {
    final class TimerController: TimerControllable {
        private(set) var timerStarted = false
        private(set) var timerStopped = false

        func startTimer(onUpdate: @escaping (Date) -> ()) {
            timerStarted = true
        }
        
        func stopTimer() {
            timerStopped = true
        }
    }
}
