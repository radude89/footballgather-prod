//
//  Mocks+AppStorage.swift
//  
//
//  Created by Radu Dan on 16.03.2022.
//

import FoundationTools
import CoreModels

// MARK: - StoredObject

extension Mocks {
    public static let storedObject = StoredObject(players: .demoPlayers)
}

// MARK: - AppStorage

extension Mocks {
    
    public static let storageKey = "test_storage_key"
    
    @available(macOS 10.15, *)
    public static let storage = Mocks.makeAppStorage()
    
    @available(macOS 10.15, *)
    public static func makeAppStorage(
        populated: Bool = false
    ) -> AppStorage {
        let commandLineHandler = makeCommandLineHandler(
            populateStorage: populated
        )
        let assembler = AppStorageAssembler(
            commandLineHandler: commandLineHandler
        )
        
        return AppStorage(
            storageKey: storageKey,
            storageFactory: assembler,
            commandLineHandler: commandLineHandler
        )
    }
    
}

// MARK: - Storageable

extension Mocks {
    
    public final class Store<Key: Hashable, Value>: Storageable {
        
        public var storedValues: [String: Value]
        
        public init(storedValues: [String: Value] = [:]) {
            self.storedValues = storedValues
        }
        
        public func store(_ object: Value, at key: String = storageKey) {
            storedValues[key] = object
        }
        
        public func load(forKey key: String = storageKey) -> Value? {
            storedValues[key]
        }
        
        public func deleteObject(forKey key: String = storageKey) {
            storedValues[key] = nil
        }
        
        public func update(_ object: Value, at key: String = storageKey) {
            deleteObject(forKey: key)
            store(object, at: key)
        }
        
        public func clear() {
            storedValues.removeAll()
        }
        
    }
    
}

// MARK: - PlayerStorageHandler

extension Mocks {
    
    public final class PlayerStorageHandler: FoundationTools.PlayerStorageHandler {
        
        public private(set) var storedPlayers: [Player]
        public private(set) var updatePlayerCalled = false
        public private(set) var deletePlayerCalled = false
        
        public init(storedPlayers: [Player] = []) {
            self.storedPlayers = storedPlayers
        }
        
        public func updatePlayer(_ player: Player) {
            updatePlayerCalled = true
        }
        
        public func deletePlayer(_ player: Player) {
            deletePlayerCalled = true
        }
        
    }
    
}

// MARK: - GatherStorageHandler

extension Mocks {
    
    public final class GatherStorageHandler: FoundationTools.GatherStorageHandler {
        
        public private(set) var gathers: [Gather]
        public private(set) var addGatherCalled = false
        
        public init(gathers: [Gather] = []) {
            self.gathers = gathers
        }
        
        public func addGather(_ gather: Gather) {
            addGatherCalled = true
        }
        
    }
    
}
