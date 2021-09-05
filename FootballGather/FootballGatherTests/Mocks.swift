//
//  Mocks.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 27.05.2021.
//

import FoundationTools
import CoreModels
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
    static let storedObject = StoredObject(players: Player.demoPlayers)
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
