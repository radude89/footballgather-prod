//
//  Mocks+CommandLineHandler.swift
//  
//
//  Created by Radu Dan on 16.03.2022.
//

import FoundationTools

extension Mocks {
    public static func makeCommandLineHandler(
        populateStorage: Bool = false
    ) -> CommandLineHandler {
        var commands = [Command.runUITests.rawValue]
        if populateStorage {
            commands.append(
                Command.populateStorage.rawValue
            )
        }
        
        return CommandLineHandler(
            commandLineArguments: commands
        )
    }
}


extension Mocks {
    public struct CommandRunner: CommandRunnable {
        public private(set) var isRunningUITests: Bool
        public private(set) var shouldPopulateStorage: Bool
        
        public init(
            isRunningUITests: Bool = false,
            shouldPopulateStorage: Bool = false
        ) {
            self.isRunningUITests = isRunningUITests
            self.shouldPopulateStorage = shouldPopulateStorage
        }
    }
}
