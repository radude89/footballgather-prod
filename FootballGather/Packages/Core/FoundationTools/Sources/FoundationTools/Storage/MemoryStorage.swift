//
//  MemoryStorage.swift
//  
//
//  Created by Radu Dan on 25.05.2021.
//

import Foundation

public final class MemoryStorage<Key: Hashable, Value> {
    
    private var cache: [Key: Value]
    
    public init(cache: [Key: Value] = [:]) {
        self.cache = cache
    }
    
    public subscript(key: Key) -> Value? {
        get { cache[key] }
        set { cache[key] = newValue }
    }
    
}

extension MemoryStorage: Storageable {
    public func store(_ object: Value, at key: Key) {
        cache[key] = object
    }
    
    public func load(forKey key: Key) -> Value? {
        cache[key]
    }
    
    public func deleteObject(forKey key: Key) {
        cache[key] = nil
    }
    
    public func clear() {
        cache.removeAll()
    }
}
