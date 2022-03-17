//
//  AppStorage+Players.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 13.01.2022.
//

import CoreModels

public protocol PlayerStorageHandler {
    var storedPlayers: [Player] { get }
    
    func updatePlayer(_ player: Player)
    func deletePlayer(_ player: Player)
}

extension AppStorage: PlayerStorageHandler {
    public var storedPlayers: [Player] {
        let storedObject = storage.load(forKey: storageKey)
        return storedObject?.players ?? []
    }
    
    public func updatePlayer(_ player: Player) {
        objectWillChange.send()
        updateStorage(with: player)
    }
    
    private func updateStorage(with player: Player) {
        if let storedObject = storage.load(forKey: storageKey) {
            var players = storedObject.players
            update(&players, with: player)
            
            let newObjectToStore = StoredObject(
                players: players,
                gathers: storedObject.gathers
            )
            
            storage.update(newObjectToStore, at: storageKey)
        } else {
            storage.store(StoredObject(players: [player]), at: storageKey)
        }
    }
    
    private func update(_ players: inout [Player], with player: Player) {
        players.removeAll { $0.id == player.id }
        players.append(player)
    }
    
    public func deletePlayer(_ player: Player) {
        guard let storedObject = storage.load(forKey: storageKey) else {
            return
        }
        
        let players = playersWithout(player, in: storedObject)
        
        let newObjectToStore = StoredObject(
            players: players,
            gathers: storedObject.gathers
        )
        
        storage.update(newObjectToStore, at: storageKey)
    }
    
    private func playersWithout(_ player: Player, in storedObject: StoredObject) -> [Player] {
        var players = storedObject.players
        players.removeAll { $0.id == player.id }
        return players
    }
}
