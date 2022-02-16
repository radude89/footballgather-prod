//
//  Gather.swift
//  
//
//  Created by Radu Dan on 13.01.2022.
//

import Foundation

public struct Gather: Equatable {
    public let id: UUID
    public let completedAt: Date
    public let score: String
    public let teamAPlayers: [Player]
    public let teamBPlayers: [Player]
    
    public init(
        id: UUID = .init(),
        completedAt: Date = .init(),
        score: String,
        teamAPlayers: [Player],
        teamBPlayers: [Player]
    ) {
        self.id = id
        self.completedAt = completedAt
        self.score = score
        self.teamAPlayers = teamAPlayers
        self.teamBPlayers = teamBPlayers
    }
}

extension Gather: Identifiable {}

extension Gather: Codable {}
