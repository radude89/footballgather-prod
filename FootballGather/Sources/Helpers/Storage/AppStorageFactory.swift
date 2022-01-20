//
//  AppStorageFactory.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 27.05.2021.
//

import FoundationTools

protocol AppStorageFactory {
    func makeAppStorage() -> AnyStorage<String, StoredObject>
}

struct AppStorageAssembler: AppStorageFactory {
    private let commandLineHandler: CommandRunnable
    
    init(commandLineHandler: CommandRunnable = CommandLineHandler()) {
        self.commandLineHandler = commandLineHandler
    }
    
    func makeAppStorage() -> AnyStorage<String, StoredObject> {
        if commandLineHandler.isRunningUITests {
            return AnyStorage(MemoryStorage<String, StoredObject>())
        }
        
        return AnyStorage(FileStorage<String, StoredObject>())
    }
}
