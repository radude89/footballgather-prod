//
//  TimerViewModel.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 10.12.2021.
//

import SwiftUI

final class TimerViewModel {
    
    private var timerController: TimerControllable
    
    @Published private(set) var remainingTimeInSeconds: Int
    
    init(
        timerController: TimerControllable = TimerController(),
        remainingTimeInSeconds: Int = 1
    ) {
        precondition(
            remainingTimeInSeconds > 0,
            "We need at least 1 second to decrease from."
        )
        
        self.timerController = timerController
        self.remainingTimeInSeconds = remainingTimeInSeconds
    }
    
    func startTimer() {
        timerController.startTimer { [weak self] _ in
            self?.onUpdateTime()
        }
    }
    
    private func onUpdateTime() {
        decreaseTime()
        stopTimeIfReachedToZero()
    }
    
    private func decreaseTime() {
        remainingTimeInSeconds -= 1
    }
    
    private func stopTimeIfReachedToZero() {
        if remainingTimeInSeconds == 0 {
            stopTimer()
        }
    }
    
    func stopTimer() {
        timerController.stopTimer()
    }
    
}
