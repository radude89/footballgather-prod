//
//  Mocks+AppStorage.swift
//  
//
//  Created by Radu Dan on 16.03.2022.
//

import FoundationTools

// MARK: - StoredObject

extension Mocks {
    public static let storedObject = StoredObject(players: .demoPlayers)
}

// MARK: - AppStorage

extension Mocks {
    
    public static let storageKey = "test_storage_key"
    
    public static let storage = Mocks.makeAppStorage()
    
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
