//
//  GatherCoordinator.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 08.02.2022.
//

import SwiftUI
import CoreModels
import TeamSelection

struct GatherCoordinator: GatherCoordinatable {
    @Binding var gatherPlayersTeams: [Team: [Player]]?

    func startGather(playersTeams: [Team: [Player]]) {
        gatherPlayersTeams = playersTeams
    }
}
