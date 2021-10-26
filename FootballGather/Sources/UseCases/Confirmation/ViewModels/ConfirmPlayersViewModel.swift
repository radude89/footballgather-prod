//
//  ConfirmPlayersViewModel.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 26.10.2021.
//

import CoreModels
import Localizable

struct ConfirmPlayersViewModel {
    
    private var playersTeams: [Team: [Player]]
    
    let teams = Team.allCases
    
    init(players: [Player]) {
        playersTeams = [:]
        playersTeams[.bench] = players
    }
    
    func sectionName(for team: Team) -> String {
        team.name.uppercased()
    }
    
    func accessibilityID(for team: Team) -> AccessibilityID {
        switch team {
        case .bench:
            return .benchView
        case .teamA:
            return .teamAView
        case .teamB:
            return .teamBView
        }
    }
    
    func players(in team: Team) -> [Player] {
        playersTeams[team] ?? []
    }
    
    func rowDescription(for player: Player) -> String {
        player.name
    }
    
}
