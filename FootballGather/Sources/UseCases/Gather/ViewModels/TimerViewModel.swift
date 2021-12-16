//
//  TimerViewModel.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 10.12.2021.
//

import SwiftUI
import FoundationTools
import Localizable

final class TimerViewModel: ObservableObject {
    
    private var timerController: TimerControllable
    private var timerState = TimerState.stopped
    private let initialTimeInSeconds: Int
    
    private var remainingTimeInSeconds: Int {
        didSet {
            formattedTime = GatherTimeFormatter(seconds: remainingTimeInSeconds).formattedTime
        }
    }
    
    @Published private(set) var formattedTime: String
    
    init(
        timerController: TimerControllable = TimerController(),
        remainingTimeInSeconds: Int = GatherDefaultTime.inSeconds
    ) {
        precondition(
            remainingTimeInSeconds > 0,
            "We need at least 1 second to decrease from."
        )
        
        self.timerController = timerController
        self.remainingTimeInSeconds = remainingTimeInSeconds
        initialTimeInSeconds = remainingTimeInSeconds
        
        formattedTime = GatherTimeFormatter(seconds: remainingTimeInSeconds).formattedTime
    }
    
    // MARK: - UI Model
    
    var cancelButtonIsEnabled: Bool {
        switch timerState {
        case .started, .paused:
            return true
        case .stopped:
            return false
        }
    }
    
    var actionButtonTitle: String {
        ActionTimerButtonModelFactory
            .makeModel(from: timerState)
            .title
    }
    
    var actionButtonAccessibilityLabel: String {
        ActionTimerButtonModelFactory
            .makeModel(from: timerState)
            .accessibilityLabel
    }
    
    // MARK: - Timer interaction
    
    func onActionTimer() {
        switch timerState {
        case .paused, .stopped:
            startTimer()
        case .started:
            pauseTimer()
        }
    }
    
    private func startTimer() {
        setTimerState(to: .started)
        timerController.startTimer { [weak self] _ in
            self?.onUpdateTime()
        }
    }
    
    private func setTimerState(to newState: TimerState) {
        timerState = newState
    }
    
    private func onUpdateTime() {
        decreaseTime()
        stopTimerIfReachedToZero()
    }
    
    private func decreaseTime() {
        remainingTimeInSeconds -= 1
    }
    
    private func stopTimerIfReachedToZero() {
        guard remainingTimeInSeconds == 0 else {
            return
        }
        
        setTimerState(to: .stopped)
        remainingTimeInSeconds = initialTimeInSeconds
        stopTimer()
    }
    
    private func pauseTimer() {
        setTimerState(to: .paused)
        formattedTime = GatherTimeFormatter(seconds: remainingTimeInSeconds).formattedTime
        stopTimer()
    }
    
    private func stopTimer() {
        timerController.stopTimer()
    }
    
    func cancelTimer() {
        setTimerState(to: .stopped)
        remainingTimeInSeconds = initialTimeInSeconds
        stopTimer()
    }
    
}
