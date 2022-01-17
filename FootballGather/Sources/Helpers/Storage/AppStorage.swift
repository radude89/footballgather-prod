//
//  AppStorage.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 25.05.2021.
//

import SwiftUI
import FoundationTools
import CoreModels

// MARK: - AppStorage

final class AppStorage: ObservableObject {
    
    private let commandLineHandler: CommandRunnable
    
    @Published var storage: AnyStorage<String, StoredObject>
    let storageKey: String
    
    init(
        storageKey: String = Storage.defaultAppKey,
        storageFactory: AppStorageFactory = AppStorageAssembler(),
        commandLineHandler: CommandRunnable = CommandLineHandler()
    ) {
        self.storageKey = storageKey
        self.commandLineHandler = commandLineHandler
        
        storage = storageFactory.makeAppStorage()
        storeDataIfNeeded()
    }
    
    private func storeDataIfNeeded() {
        if commandLineHandler.isRunningUITests && commandLineHandler.shouldPopulateStorage {
            storeData()
        }
    }
    
    private func storeData() {
        storage.store(
            StoredObject(players: .demoPlayers, gathers: .demoGathers),
            at: storageKey
        )
    }
    
    func clear() {
        storage.clear()
    }
    
}
