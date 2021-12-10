//
//  TimerControllerTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 07.12.2021.
//

import XCTest
import Combine
@testable import FootballGather

final class TimerControllerTests: XCTestCase {

    func testTimer() {
        let timerExpectation = expectation(description: "Timer Expectation")
        let sut = TimerController(timeInterval: 0.0000001, runLoop: .current, runLoopMode: .default)
        
        sut.startTimer { _ in
            sut.stopTimer()
            timerExpectation.fulfill()
        }
        
        wait(for: [timerExpectation], timeout: 0.1)
    }
    
}
