//
//  Storage.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 27.05.2021.
//

import CoreModels

public enum Storage {}

public extension Storage {
    static let defaultAppKey = "com.footballgather.storage"
}

public struct StoredObject: Codable {
    public var players: [Player]
    public var gathers: [Gather]
    
    public init(players: [Player] = [], gathers: [Gather] = []) {
        self.players = players
        self.gathers = gathers
    }
}

extension StoredObject: @unchecked Sendable {}
