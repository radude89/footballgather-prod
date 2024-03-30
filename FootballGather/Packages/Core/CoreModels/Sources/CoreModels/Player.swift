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
    public var position: Position
    public var skill: Skill
    
    public init(
        id: UUID = .init(),
        name: String,
        position: Position = .unknown,
        skill: Skill = .unknown
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

extension Player: Sendable {}

extension Player: Codable {
    enum CodingKeys: String, CodingKey {
        case id, name, position, skill
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        position = try container.decodeIfPresent(Player.Position.self, forKey: .position) ?? .unknown
        skill = try container.decodeIfPresent(Player.Skill.self, forKey: .skill) ?? .unknown
    }
}
