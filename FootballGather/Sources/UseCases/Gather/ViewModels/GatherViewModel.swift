//
//  GatherViewModel.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 24.11.2021.
//

import CoreModels

struct GatherViewModel {
    private let playersTeams: [Team: [Player]]
    
    init(playersTeams: [Team: [Player]]) {
        self.playersTeams = playersTeams
    }
    
    func players(in team: Team) -> [Player] {
        playersTeams[team] ?? []
    }
}
