//
//  GatherViewModel.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 29.11.2021.
//

import CoreModels

struct GatherViewModel {
    let playersTeams: [Team: [Player]]
    
    init(playersTeams: [Team: [Player]]) {
        self.playersTeams = playersTeams
    }
}
