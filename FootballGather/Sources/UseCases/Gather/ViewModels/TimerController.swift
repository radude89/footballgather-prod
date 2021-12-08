//
//  TimerController.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 08.12.2021.
//

import Foundation
import Combine

protocol TimerControllable {
    mutating func startTimer()
    mutating func stopTimer()
}

struct TimerController {
    private(set) var timer: Timer.TimerPublisher
    private let timeInterval: TimeInterval
    private let runLoop: RunLoop
    private let runLoopMode: RunLoop.Mode
    private var cancellable: Cancellable?
    
    init(
        timeInterval: TimeInterval = 1,
        runLoop: RunLoop = .main,
        runLoopMode: RunLoop.Mode = .common
    ) {
        self.timeInterval = timeInterval
        self.runLoop = runLoop
        self.runLoopMode = runLoopMode
        self.timer = Timer.TimerPublisher(interval: timeInterval, runLoop: runLoop, mode: runLoopMode)
    }
}

extension TimerController: TimerControllable {
    mutating func startTimer() {
        timer = Timer.publish(every: timeInterval, on: runLoop, in: runLoopMode)
        cancellable = timer.connect()
    }
    
    mutating func stopTimer() {
        timer.connect().cancel()
        cancellable = nil
    }
}
