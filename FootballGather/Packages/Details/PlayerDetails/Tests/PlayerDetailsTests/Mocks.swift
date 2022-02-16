//
//  Mocks.swift
//  
//
//  Created by Radu Dan on 16.02.2022.
//

import FoundationTools

enum Mocks {}

// MARK: - Storage

extension Mocks {
    static var storageKey = "test_storage_key"
    
    static let storage = AppStorage(
        storageKey: Mocks.storageKey,
        commandLineHandler: Mocks.CommandRunner()
    )
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
