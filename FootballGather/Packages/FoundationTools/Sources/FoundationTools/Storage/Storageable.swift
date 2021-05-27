//
//  Storageable.swift
//  
//
//  Created by Radu Dan on 25.05.2021.
//

import Foundation

public protocol Storageable {
    associatedtype Key = Hashable
    associatedtype Object
    
    func store(_ object: Object, at key: Key)
    func load(forKey key: Key) -> Object?
    func update(_ object: Object, at key: Key)
    func deleteObject(forKey key: Key)
    func clear()
}

public extension Storageable {
    func update(_ object: Object, at key: Key) {
        deleteObject(forKey: key)
        store(object, at: key)
    }
}
