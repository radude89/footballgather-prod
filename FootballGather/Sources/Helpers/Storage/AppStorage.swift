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
    
    func addPlayer(_ player: Player)
}

extension AppStorage: PlayerStorageHandler {
    var storedPlayers: [Player] {
        let storedObject = storage.load(forKey: storageKey)
        return storedObject?.players ?? []
    }
    
    func addPlayer(_ player: Player) {
        objectWillChange.send()
        updateStorage(with: player)
    }
    
    private func updateStorage(with player: Player) {
        if var players = storage.load(forKey: storageKey)?.players {
            players.append(player)
            storage.update(StoredObject(players: players), at: storageKey)
        } else {
            storage.store(StoredObject(players: [player]), at: storageKey)
        }
    }
}
