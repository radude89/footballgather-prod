//
//  Player+Skill.swift
//  Player+Skill
//
//  Created by Radu Dan on 08.09.2021.
//

import Foundation

public extension Player {
    enum Skill: String {
        case unknown
        case rookie
        case amateur
        case professional
    }
}

extension Player.Skill: CaseIterable {}

extension Player.Skill: Codable {}
