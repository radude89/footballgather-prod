//
//  AppStorage+Gathers.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 13.01.2022.
//

import CoreModels

public protocol GatherStorageHandler {
    var gathers: [Gather] { get }
    
    func addGather(_ gather: Gather)
    func deleteGather(_ gather: Gather)
}

@available(macOS 10.15, *)
extension AppStorage: GatherStorageHandler {
    public var gathers: [Gather] {
        let storedObject = storage.load(forKey: storageKey)
        return storedObject?.gathers ?? []
    }
    
    public func addGather(_ gather: Gather) {
        let storedObject = storage.load(forKey: storageKey)
        var storedGathers = storedObject?.gathers ?? []
        storedGathers.removeAll { $0.id == gather.id }
        storedGathers.append(gather)
        
        objectWillChange.send()
        
        let newObjectToStore = StoredObject(
            players: storedObject?.players ?? [],
            gathers: storedGathers
        )
        storage.update(newObjectToStore, at: storageKey)
    }
    
    public func deleteGather(_ gather: Gather) {
        guard let storedObject = storage.load(forKey: storageKey) else {
            return
        }
        
        let gathers = gathersWithout(gather, in: storedObject)
        
        let newObjectToStore = StoredObject(
            players: storedObject.players,
            gathers: gathers
        )
        
        storage.update(newObjectToStore, at: storageKey)
    }
    
    private func gathersWithout(_ gather: Gather, in storedObject: StoredObject) -> [Gather] {
        var gathers = storedObject.gathers
        gathers.removeAll { $0.id == gather.id }
        return gathers
    }
}
