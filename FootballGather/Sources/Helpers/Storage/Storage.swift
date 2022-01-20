//
//  Storage.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 27.05.2021.
//

import CoreModels

enum Storage {}

extension Storage {
    static let defaultAppKey = "com.footballgather.storage"
}

struct StoredObject: Codable {
    var players: [Player] = []
    var gathers: [Gather] = []
}
