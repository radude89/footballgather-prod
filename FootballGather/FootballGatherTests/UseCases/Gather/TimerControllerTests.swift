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
    
    private var cancellables: Set<AnyCancellable>!
    private var sut: TimerController!
    
    override func setUp() {
        super.setUp()
        
        cancellables = []
        sut = TimerController(timeInterval: 0.0001, runLoop: .current, runLoopMode: .default)
    }
    
    override func tearDown() {
        sut.stopTimer()
        cancellables = []
        
        super.tearDown()
    }
    
    func testTimer() {
        let timerExpectation = expectation(description: "Timer Expectation")
        
        sut.startTimer()

        sut.timer.sink { [weak self] date in
            self?.sut.stopTimer()
            timerExpectation.fulfill()
        }
        .store(in: &cancellables)
        
        wait(for: [timerExpectation], timeout: 3)
    }
    
}
