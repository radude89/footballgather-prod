//
//  TimerViewModel.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 10.12.2021.
//

import SwiftUI
import Combine
import FoundationTools
import GatherAssets

@Observable
final class TimerViewModel: @unchecked Sendable {
    
    private var timerController: TimerControllable
    private var timerState = TimerState.stopped
    private let initialTimeInSeconds: Int
    private var timeSettings: TimeSettings
    private let timerUpdateDispatcher: DispatchHelper
    
    @ObservationIgnored
    let notificationScheduler: NotificationScheduler
    
    @ObservationIgnored
    var notificationPermissionGranter: NotificationPermissionGrantable
    
    @ObservationIgnored
    lazy var sceneChangeHandler = TimerSceneChangeHandler(delegate: self)
    
    @ObservationIgnored
    let onFormattedTimeChanged: ((String) -> Void)?
    
    var remainingTimeInSeconds: Int {
        didSet {
            updateFormattedTime()
        }
    }
    
    var timeIsUp = false
    
    private(set) var formattedTime = "" {
        didSet {
            onFormattedTimeChanged?(formattedTime)
        }
    }
    
    init(
        timerController: TimerControllable = TimerController(),
        timeSettings: TimeSettings = .init(),
        notificationPermissionGranter: NotificationPermissionGrantable = NotificationPermissionGranter(),
        notificationScheduler: NotificationScheduler = .init(),
        timerUpdateDispatcher: DispatchHelper = DispatchQueue.main,
        onFormattedTimeChanged: ((String) -> Void)? = nil
    ) {
        precondition(
            timeSettings.remainingTimeInSeconds >= GatherDefaultTime.minAllowedTimeInSeconds,
            "We need at least \(GatherDefaultTime.minAllowedTimeInSeconds) seconds to decrease from."
        )
        
        self.timeSettings = timeSettings
        self.timerController = timerController
        self.remainingTimeInSeconds = timeSettings.remainingTimeInSeconds
        self.initialTimeInSeconds = timeSettings.remainingTimeInSeconds
        self.notificationPermissionGranter = notificationPermissionGranter
        self.notificationScheduler = notificationScheduler
        self.timerUpdateDispatcher = timerUpdateDispatcher
        self.onFormattedTimeChanged = onFormattedTimeChanged
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
    
    @MainActor
    var actionButtonTitle: String {
        ActionTimerButtonModelFactory
            .makeModel(from: timerState)
            .title
    }
    
    @MainActor
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
        timerUpdateDispatcher.executeAsync { [weak self] in
            self?.timeIsUp = true
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
        timerUpdateDispatcher.executeAsync { [weak self] in
            guard let self else { return }
            formattedTime = GatherTimeFormatter(seconds: remainingTimeInSeconds).formattedTime
        }
    }
    
    var timerIsRunning: Bool {
        timerState == .started
    }
    
}
