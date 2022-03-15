//
//  Mocks.swift
//  
//
//  Created by Radu Dan on 18.02.2022.
//

import Foundation
import Combine
import FoundationTools
import NotificationCenter
@testable import Gather

enum Mocks {}

// MARK: - Storage

extension Mocks {
    static var storageKey = "test_storage_key"
    
    static let storage = AppStorage(
        storageKey: Mocks.storageKey,
        commandLineHandler: Mocks.CommandRunner()
    )
}

// MARK: - StoredObject

extension Mocks {
    static let storedObject = StoredObject(players: .demoPlayers)
}

// MARK: - Command Runner

extension Mocks {
    struct CommandRunner: CommandRunnable {
        private(set) var isRunningUITests: Bool
        private(set) var shouldPopulateStorage: Bool
        
        init(
            isRunningUITests: Bool = false,
            shouldPopulateStorage: Bool = false
        ) {
            self.isRunningUITests = isRunningUITests
            self.shouldPopulateStorage = shouldPopulateStorage
        }
    }
}

// MARK: - Timer

extension Mocks {
    static let timer = Timer.TimerPublisher(interval: 0.0000001, runLoop: .current, mode: .default)
}

extension Mocks {
    final class TimerController: TimerControllable {
        private(set) var timerStarted = false
        private(set) var timerStopped = false
        private let remainingTimeUnit: Int
        private var cancellable: AnyCancellable?
        
        init(remainingTimeUnit: Int = 1) {
            precondition(remainingTimeUnit > 0)
            self.remainingTimeUnit = remainingTimeUnit
        }

        func startTimer(onUpdate: @escaping (Date) -> ()) {
            timerStarted = true
            updateTime(onUpdate)
        }
        
        private func updateTime(_ onUpdate: @escaping (Date) -> ()) {
            cancellable = (0 ..< remainingTimeUnit).publisher.sink { _ in
                onUpdate(Date())
            }
        }
        
        func stopTimer() {
            timerStopped = true
        }
    }
}

// MARK: - Publishers

extension Mocks {
    final class ValueSpy<Value> {
        private(set) var values: [Value] = []
        private var cancellable: AnyCancellable?
        
        init(_ publisher: AnyPublisher<Value, Never>) {
            cancellable = publisher.sink(receiveValue: { [weak self] value in
                self?.values.append(value)
            })
        }
    }
}

// MARK: - Notifications

extension Mocks {
    final class NotificationCenter: Gather.NotificationCenter {
        private(set) var authorizationStatus: UNAuthorizationStatus
        private(set) var removeAllPendingNotificationRequestsCalled = false
        private(set) var request: UNNotificationRequest?
        
        private let authError: Error?
        private let addRequestError: Error?
        
        
        init(
            authorizationStatus: UNAuthorizationStatus,
            authError: Error? = nil,
            addRequestError: Error? = nil
        ) {
            self.authorizationStatus = authorizationStatus
            self.authError = authError
            self.addRequestError = addRequestError
        }
        
        func requestAuthorization(options: UNAuthorizationOptions) async throws -> Bool {
            if let error = authError {
                throw error
            }
            
            return authorizationStatus == .authorized || authorizationStatus == .notDetermined
        }
        
        func add(_ request: UNNotificationRequest) async throws {
            if let error = addRequestError {
                throw error
            }
            
            self.request = request
        }
        
        func removeAllPendingNotificationRequests() {
            removeAllPendingNotificationRequestsCalled = true
            request = nil
        }
    }
}

extension Mocks {
    final class NotificationPermissionGranter: NotificationPermissionGrantable {
        private(set) var hasGrantedPermissions: Bool
        private(set) var askForPermissionsCalled = false
        
        init(hasGrantedPermissions: Bool = true) {
            self.hasGrantedPermissions = hasGrantedPermissions
        }
        
        func askForPermissions() async {
            askForPermissionsCalled = true
        }
    }
}

// MARK: - Scene transition

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
