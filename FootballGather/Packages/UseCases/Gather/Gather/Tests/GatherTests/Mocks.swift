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
    struct NotificationCenter: Gather.NotificationCenter {
        private(set) var authorizationStatus: UNAuthorizationStatus
        
        init(authorizationStatus: UNAuthorizationStatus) {
            self.authorizationStatus = authorizationStatus
        }
        
        func requestAuthorization(options: UNAuthorizationOptions) async throws -> Bool {
            true
        }
        
        func add(_ request: UNNotificationRequest) async throws {
        }
    }
}
