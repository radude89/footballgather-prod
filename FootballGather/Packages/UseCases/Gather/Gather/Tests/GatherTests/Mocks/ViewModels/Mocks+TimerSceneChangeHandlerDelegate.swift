//
//  Mocks+TimerSceneChangeHandlerDelegate.swift
//  
//
//  Created by Radu Dan on 21.03.2022.
//

import Foundation
@testable import Gather

extension Mocks {
    
    final class TimerSceneChangeHandlerDelegate: Gather.TimerSceneChangeHandlerDelegate {
        
        private(set) var timerIsRunning: Bool
        private(set) var remainingTimeInSeconds: Int
        private(set) var pauseTimerCalled = false
        private(set) var startTimerCalled = false
        private(set) var timerReachedZeroCalled = false
        private(set) var updateRemainingTimeCalled = false
        private(set) var scheduleNotificationCalled = false
        private(set) var cancelNotificationsCalled = false
        
        init(
            timerIsRunning: Bool = false,
            remainingTimeInSeconds: Int = 0
        ) {
            self.timerIsRunning = timerIsRunning
            self.remainingTimeInSeconds = remainingTimeInSeconds
        }
        
        func pauseTimer() {
            pauseTimerCalled = true
        }
        
        func startTimer() {
            startTimerCalled = true
        }
        
        func timerReachedZero() {
            timerReachedZeroCalled = true
        }
        
        func updateRemainingTime(accumulatedRunningTime: Int) {
            updateRemainingTimeCalled = true
        }
        
        func scheduleNotification() async {
            scheduleNotificationCalled = true
        }
        
        func cancelNotifications() {
            cancelNotificationsCalled = true
        }
        
    }
    
}
