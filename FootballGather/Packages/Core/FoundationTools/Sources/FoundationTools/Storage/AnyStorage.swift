//
//  AnyStorage.swift
//  
//
//  Created by Radu Dan on 25.05.2021.
//

import Foundation

public final class AnyStorage<Key: Hashable, Value>: Storageable {
    
    private let _store: (Value, Key) -> ()
    private let _load: (Key) -> Value?
    private let _delete: (Key) -> ()
    private let _clear: () -> Void
    
    public init<S: Storageable>(_ wrapped: S) where S.Key == Key, S.Object == Value {
        _store = wrapped.store
        _load = wrapped.load
        _delete = wrapped.deleteObject
        _clear = wrapped.clear
    }
    
    public func store(_ object: Value, at key: Key) {
        _store(object, key)
    }
    
    public func load(forKey key: Key) -> Value? {
        _load(key)
    }
    
    public func deleteObject(forKey key: Key) {
        _delete(key)
    }
    
    public func clear() {
        _clear()
    }
    
}
