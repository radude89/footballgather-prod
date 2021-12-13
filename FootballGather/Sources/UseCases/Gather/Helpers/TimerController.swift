//
//  TimerController.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 08.12.2021.
//

import Foundation
import Combine

protocol TimerControllable: AnyObject {
    func startTimer(onUpdate: @escaping (Date) -> ())
    func stopTimer()
}

final class TimerController {
    private var timer: Publishers.Autoconnect<Timer.TimerPublisher>?
    private let timeInterval: TimeInterval
    private let runLoop: RunLoop
    private let runLoopMode: RunLoop.Mode
    private var cancellable: AnyCancellable?
    
    init(
        timeInterval: TimeInterval = 1,
        runLoop: RunLoop = .main,
        runLoopMode: RunLoop.Mode = .common
    ) {
        self.timeInterval = timeInterval
        self.runLoop = runLoop
        self.runLoopMode = runLoopMode
    }
}

extension TimerController: TimerControllable {
    func startTimer(onUpdate: @escaping (Date) -> ()) {
        timer = Timer.publish(every: timeInterval, on: runLoop, in: runLoopMode).autoconnect()
        cancellable = timer?.sink { date in
            onUpdate(date)
        }
    }
    
    func stopTimer() {
        timer?.upstream.connect().cancel()
        cancellable = nil
    }
}
