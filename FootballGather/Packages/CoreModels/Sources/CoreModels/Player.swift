//
//  Player.swift
//  
//
//  Created by Radu Dan on 24.05.2021.
//

import Foundation

public struct Player {
    public let id: UUID
    public var name: String
    public var position: Position?
    public var skill: Skill?
    
    public init(
        id: UUID = .init(),
        name: String,
        position: Position? = nil,
        skill: Skill? = nil
    ) {
        self.id = id
        self.name = name
        self.position = position
        self.skill = skill
    }
}

extension Player: Identifiable {}

extension Player: Equatable {}

extension Player: Hashable {}
