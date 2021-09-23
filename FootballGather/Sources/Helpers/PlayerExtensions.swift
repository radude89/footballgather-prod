//
//  PlayerExtensions.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 24.05.2021.
//

import CoreModels

extension Array where Element == Player {
    static let demoPlayers: [Player] = [
        Player(name: "John"),
        Player(name: "Jane"),
        Player(name: "Arthur")
    ]
    
    static let demoPlayer = demoPlayers.randomElement()!
}

extension Player {
    static let demoPlayers = Array.demoPlayers
    static let demo = demoPlayers.randomElement()!
}
