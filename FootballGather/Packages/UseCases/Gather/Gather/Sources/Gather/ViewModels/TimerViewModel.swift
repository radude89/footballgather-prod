//
//  TimerViewModel.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 10.12.2021.
//

import SwiftUI
import FoundationTools
import GatherAssets

final class TimerViewModel: ObservableObject, @unchecked Sendable {
    
    private var timerController: TimerControllable
    private var timerState = TimerState.stopped
    private let initialTimeInSeconds: Int
    private var timeSettings: TimeSettings
    
    let notificationScheduler: NotificationScheduler
    var notificationPermissionGranter: NotificationPermissionGrantable
    lazy var sceneChangeHandler = TimerSceneChangeHandler(delegate: self)
    
    var remainingTimeInSeconds: Int {
        didSet {
            updateFormattedTime()
        }
    }
    
    @Published private(set) var formattedTime = ""
    @Published var timeIsUp = false
    
    init(
        timerController: TimerControllable = TimerController(),
        timeSettings: TimeSettings = .init(),
        notificationPermissionGranter: NotificationPermissionGrantable = NotificationPermissionGranter(),
        notificationScheduler: NotificationScheduler = .init()
    ) {
        precondition(
            timeSettings.remainingTimeInSeconds >= GatherDefaultTime.minAllowedTimeInSeconds,
            "We need at least \(GatherDefaultTime.minAllowedTimeInSeconds) seconds to decrease from."
        )
        
        self.timeSettings = timeSettings
        self.timerController = timerController
        self.remainingTimeInSeconds = timeSettings.remainingTimeInSeconds
        self.notificationPermissionGranter = notificationPermissionGranter
        self.notificationScheduler = notificationScheduler
        
        initialTimeInSeconds = remainingTimeInSeconds
        updateFormattedTime()
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
    
    func startTimer() {
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
        if remainingTimeInSeconds == 0 {
            timerReachedZero()
        }
    }
    
    func timerReachedZero() {
        cancelTimer()
        DispatchQueue.main.async {
            self.timeIsUp = true
        }
    }
    
    func cancelTimer() {
        stopTimer()
        setTimerState(to: .stopped)
        resetTime()
    }
    
    private func stopTimer() {
        timerController.stopTimer()
    }
    
    private func resetTime() {
        remainingTimeInSeconds = initialTimeInSeconds
    }
    
    func pauseTimer() {
        stopTimer()
        setTimerState(to: .paused)
        updateFormattedTime()
    }
    
    private func updateFormattedTime() {
        DispatchQueue.main.async {
            self.formattedTime = GatherTimeFormatter(seconds: self.remainingTimeInSeconds).formattedTime
        }
    }
    
    var timerIsRunning: Bool {
        timerState == .started
    }
    
}
