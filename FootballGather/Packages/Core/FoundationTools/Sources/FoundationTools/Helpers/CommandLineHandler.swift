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

public protocol CommandRunnable: Sendable {
    var isRunningUITests: Bool { get }
    var shouldPopulateStorage: Bool { get }
}

public struct CommandLineHandler: CommandRunnable {
    private let commandLineArguments: [String]
    
    public init(commandLineArguments: [String] = CommandLine.arguments()) {
        self.commandLineArguments = commandLineArguments
    }
    
    public var isRunningUITests: Bool {
        commandLineArguments.contains(Command.runUITests.rawValue)
    }
    
    public var shouldPopulateStorage: Bool {
        commandLineArguments.contains(Command.populateStorage.rawValue)
    }
}

extension CommandLine {
    /// Get the command-line arguments passed to this process.
    ///
    /// - Returns: An array of command-line arguments.
    public static func arguments() -> [String] {
        UnsafeBufferPointer(start: unsafeArgv, count: Int(argc)).lazy
            .compactMap { $0 }
            .compactMap { String(validatingUTF8: $0) }
    }
}
