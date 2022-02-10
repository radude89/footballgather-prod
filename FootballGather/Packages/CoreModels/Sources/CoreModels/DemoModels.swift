//
//  DemoModels.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 24.05.2021.
//

import Foundation

public extension Array where Element == Player {
    static let demoPlayers: [Player] = [
        Player(name: "John"),
        Player(name: "Jane"),
        Player(name: "Arthur")
    ]
    
    static let demoPlayer = demoPlayers.randomElement()!
}

public extension Player {
    static let demoPlayers = Array.demoPlayers
    static let demo = demoPlayers.randomElement()!
}

public extension Array where Element == Gather {
    static let demoGathers: [Gather] = [
        Gather(score: "0:0", teamAPlayers: .demoPlayers, teamBPlayers: .demoPlayers),
        Gather(score: "2:0", teamAPlayers: .demoPlayers, teamBPlayers: .demoPlayers),
        Gather(score: "1:3", teamAPlayers: .demoPlayers, teamBPlayers: .demoPlayers)
    ]
}

public extension Gather {
    static let demoGathers = Array.demoGathers
}
