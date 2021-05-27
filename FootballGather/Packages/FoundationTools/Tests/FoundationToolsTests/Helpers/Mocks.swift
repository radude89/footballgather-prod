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
