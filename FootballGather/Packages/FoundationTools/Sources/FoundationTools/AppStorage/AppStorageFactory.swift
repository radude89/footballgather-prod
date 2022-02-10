//
//  AppStorageFactory.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 27.05.2021.
//

import Foundation

public protocol AppStorageFactory {
    func makeAppStorage() -> AnyStorage<String, StoredObject>
}

public struct AppStorageAssembler: AppStorageFactory {
    private let commandLineHandler: CommandRunnable
    
    public init(commandLineHandler: CommandRunnable = CommandLineHandler()) {
        self.commandLineHandler = commandLineHandler
    }
    
    public func makeAppStorage() -> AnyStorage<String, StoredObject> {
        if commandLineHandler.isRunningUITests {
            return AnyStorage(MemoryStorage<String, StoredObject>())
        }
        
        return AnyStorage(FileStorage<String, StoredObject>())
    }
}
