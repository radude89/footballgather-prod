//
//  Mocks.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 27.05.2021.
//

import FoundationTools
import CoreModels
import SwiftUI
import Combine
@testable import FootballGather

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

// MARK: - PlayersViewModel

extension Mocks {
    static func makeButtonModel(
        title: String = "Button",
        accessibility: PlayersViewModel.AccessibilityModel = .init(
            id: .doneButton,
            hint: "Hint",
            label: "Label"
        )
    ) -> PlayersViewModel.ButtonModel {
        PlayersViewModel.ButtonModel(title: title, accessibility: accessibility)
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
