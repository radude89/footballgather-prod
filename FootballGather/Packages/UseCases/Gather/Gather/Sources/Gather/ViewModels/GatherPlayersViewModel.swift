//
//  GatherPlayersViewModel.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 24.11.2021.
//

import CoreModels

@MainActor
struct GatherPlayersViewModel {
    private let playersTeams: [Team: [Player]]
    
    init(playersTeams: [Team: [Player]]) {
        self.playersTeams = playersTeams
    }
    
    func sectionName(for team: Team) -> String {
        team.name.uppercased()
    }
    
    func players(in team: Team) -> [Player] {
        playersTeams[team] ?? []
    }
}
