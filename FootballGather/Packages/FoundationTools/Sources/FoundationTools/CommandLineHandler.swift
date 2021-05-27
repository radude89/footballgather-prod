//
//  CommandLineHandler.swift
//  
//
//  Created by Radu Dan on 25.05.2021.
//

import Foundation

public enum Command: String {
    case runUITests = "-uitests"
    case populateStorage = "-populate-storage"
}

public protocol CommandRunnable {
    var isRunningUITests: Bool { get }
    var shouldPopulateStorage: Bool { get }
}

public struct CommandLineHandler: CommandRunnable {
    private let commandLineArguments: [String]
    
    public init(commandLineArguments: [String] = CommandLine.arguments) {
        self.commandLineArguments = commandLineArguments
    }
    
    public var isRunningUITests: Bool {
        commandLineArguments.contains(Command.runUITests.rawValue)
    }
    
    public var shouldPopulateStorage: Bool {
        commandLineArguments.contains(Command.populateStorage.rawValue)
    }
}
