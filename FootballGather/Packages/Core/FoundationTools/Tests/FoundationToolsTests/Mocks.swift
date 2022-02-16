//
//  Mocks.swift
//  
//
//  Created by Radu Dan on 25.05.2021.
//

import Foundation
@testable import FoundationTools

enum Mocks {}

// MARK: - Storage

extension Mocks {
    static var storageKey = "test_storage_key"
    
    static let storage = AppStorage(
        storageKey: Mocks.storageKey,
        commandLineHandler: Mocks.CommandRunner()
    )
    
    final class Store<Key: Hashable, Value>: Storageable {
        var storedValues: [String: Value] = [:]
        
        func store(_ object: Value, at key: String = storageKey) {
            storedValues[key] = object
        }
        
        func load(forKey key: String = storageKey) -> Value? {
            storedValues[key]
        }
        
        func deleteObject(forKey key: String = storageKey) {
            storedValues[key] = nil
        }
        
        func update(_ object: Value, at key: String = storageKey) {
            deleteObject(forKey: key)
            store(object, at: key)
        }
        
        func clear() {
            storedValues.removeAll()
        }
    }
}

// MARK: - FileStorage

extension Mocks {
    static func makeFileStorage(
        _ fileManager: FileManager = .init(),
        filePath: String = NSTemporaryDirectory() + "com.mocks",
        storageCoder: StorageCoder = makeStorageCoder()
    ) throws -> FileStorage<String, [String]> {
        
        try? fileManager.removeItem(atPath: filePath)
        try fileManager.createDirectory(
            atPath: filePath,
            withIntermediateDirectories: false
        )
        
        let url = URL(fileURLWithPath: filePath)
        
        return FileStorage(
            fileManager: fileManager,
            documentsURL: url,
            coder: storageCoder
        )
    }
    
    static func makeStorageCoder(
        encoder: StorageEncoder = Mocks.Encoder(),
        decoder: StorageDecoder = Mocks.Decoder()
    ) -> StorageCoder {
        StorageCoder(
            encoder: encoder,
            decoder: decoder
        )
    }
}

// MARK: - StorageCoder

extension Mocks {
    final class Encoder: StorageEncoder {
        var error: StorageError?
        var encoder: StorageEncoder = JSONEncoder()
        
        func encode<T: Encodable>(_ value: T) throws -> Data {
            guard error == nil else { throw error! }
            
            return try encoder.encode(value)
        }
    }
    
    final class Decoder: StorageDecoder {
        var error: StorageError?
        var decoder: StorageDecoder = JSONDecoder()
        
        func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
            guard error == nil else { throw error! }
            
            return try decoder.decode(type, from: data)
        }
    }
    
    enum StorageError: Swift.Error {
        case generic
    }
}

// MARK: - StoredObject

extension Mocks {
    static let storedObject = StoredObject(players: .demoPlayers)
}

// MARK: - Command Runner

extension Mocks {
    struct CommandRunner: CommandRunnable {
        private(set) var isRunningUITests: Bool
        private(set) var shouldPopulateStorage: Bool
        
        init(
            isRunningUITests: Bool = false,
            shouldPopulateStorage: Bool = false
        ) {
            self.isRunningUITests = isRunningUITests
            self.shouldPopulateStorage = shouldPopulateStorage
        }
    }
}
