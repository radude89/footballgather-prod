//
//  PlayerDecoderTests.swift
//
//
//  Created by Radu Dan on 21.06.2024.
//

import Foundation
import Testing
@testable import CoreModels

struct PlayerDecoderTests {
    
    private enum Mocks {
        static let id = UUID()
        static let name = "John Doe"
        static let position: Player.Position = .forward
        static let skill: Player.Skill = .amateur
        static let jsonWithAllFields = """
            {
                "id": "\(Mocks.id.uuidString)",
                "name": "\(Mocks.name)",
                "position": "\(Mocks.position.rawValue)",
                "skill": "\(Mocks.skill.rawValue)"
            }
        """
        static let jsonWithMissingFields = """
            {
                "id": "\(Mocks.id.uuidString)",
                "name": "\(Mocks.name)"
            }
        """
    }
    
    @Test("Player initializing from decoded object", arguments: [
        Mocks.jsonWithAllFields, Mocks.jsonWithMissingFields
    ])
    func playerInitializing(json: String) throws {
        let jsonData = json.data(using: .utf8)!
        let isJsonWithMissingFields = json == Mocks.jsonWithMissingFields
        let player = try JSONDecoder().decode(Player.self, from: jsonData)

        #expect(
            player == .init(
                id: Mocks.id,
                name: Mocks.name,
                position: isJsonWithMissingFields ? .unknown : Mocks.position,
                skill: isJsonWithMissingFields ? .unknown : Mocks.skill
            )
        )
    }

}
