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
    
    private let storageKey: String
    private let commandLineHandler: CommandRunnable
    
    @Published var storage: AnyStorage<String, StoredObject>
    
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
            StoredObject(players: .demoPlayers),
            at: storageKey
        )
    }
    
    func clear() {
        storage.clear()
    }
    
}

// MARK: - AppStorage+Players

protocol PlayerStorageHandler {
    var storedPlayers: [Player] { get }
    
    func updatePlayers(_ newPlayers: [Player])
}

extension AppStorage: PlayerStorageHandler {
    var storedPlayers: [Player] {
        let storedObject = storage.load(forKey: storageKey)
        return storedObject?.players ?? []
    }
    
    func updatePlayers(_ newPlayers: [Player]) {
        objectWillChange.send()
        updateStorage(with: newPlayers)
    }
    
    private func updateStorage(with newPlayers: [Player]) {
        if var alreadyStoredObject = storage.load(forKey: storageKey) {
            alreadyStoredObject.players = newPlayers
            storage.update(alreadyStoredObject, at: storageKey)
        } else {
            storage.store(StoredObject(players: newPlayers), at: storageKey)
        }
    }
}
