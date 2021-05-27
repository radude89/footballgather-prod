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
