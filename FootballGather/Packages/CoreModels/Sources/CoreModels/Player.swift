//
//  Player.swift
//  
//
//  Created by Radu Dan on 24.05.2021.
//

import Foundation

public struct Player {
    public let id: UUID
    public let name: String
    
    public init(id: UUID = .init(), name: String) {
        self.id = id
        self.name = name
    }
}

extension Player: Identifiable {}

extension Player: Equatable {}

extension Player: Hashable {}
