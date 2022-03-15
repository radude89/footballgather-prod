//
//  TimerSceneChangeHandler.swift
//  
//
//  Created by Radu Dan on 09.03.2022.
//

import SwiftUI

protocol TimerSceneChangeHandlerDelegate: AnyObject {
    var timerIsRunning: Bool { get }
    var remainingTimeInSeconds: Int { get }
    
    func pauseTimer()
    func startTimer()
    func timerReachedZero()
    func updateRemainingTime(accumulatedRunningTime: Int)
    func scheduleNotification() async
    func cancelNotifications()
}

final class TimerSceneChangeHandler {
    
    private weak var delegate: TimerSceneChangeHandlerDelegate?
    
    private var dateHasTransitionToBackground: Date?
    private var shouldMeasureTimeInBackground = false
    
    init(delegate: TimerSceneChangeHandlerDelegate) {
        self.delegate = delegate
    }
    
    func onScenePhaseChanged(to newState: ScenePhase) async {
        switch newState {
        case .inactive, .background:
            await handleScenePhaseChangedToBackground()
        case .active:
            handleScenePhaseChangedToActive()
        @unknown default:
            break
        }
    }
    
    // MARK: - Background phase methods
    
    private func handleScenePhaseChangedToBackground() async {
        guard let delegate = delegate, delegate.timerIsRunning else {
            return
        }
        
        await delegate.scheduleNotification()
        delegate.pauseTimer()
        startCountingTime()
    }
    
    private func startCountingTime() {
        shouldMeasureTimeInBackground = true
        
        if dateHasTransitionToBackground == nil {
            dateHasTransitionToBackground = Date()
        }
    }
    
    // MARK: - Foreground phase methods
    
    private func handleScenePhaseChangedToActive() {
        guard shouldMeasureTimeInBackground else {
            return
        }
        
        delegate?.cancelNotifications()
        updateRemainingTime()
        stopCountingTime()
        
        if hasReachedZero {
            delegate?.timerReachedZero()
        } else {
            delegate?.startTimer()
        }
    }
    
    private func updateRemainingTime() {
        let accumulatedRunningTime = Int(Date().timeIntervalSince(dateHasTransitionToBackground!))
        delegate?.updateRemainingTime(accumulatedRunningTime: accumulatedRunningTime)
    }
    
    private func stopCountingTime() {
        dateHasTransitionToBackground = nil
        shouldMeasureTimeInBackground  = false
    }
    
    private var hasReachedZero: Bool {
        delegate?.remainingTimeInSeconds ?? 0 <= 0
    }
    
}
