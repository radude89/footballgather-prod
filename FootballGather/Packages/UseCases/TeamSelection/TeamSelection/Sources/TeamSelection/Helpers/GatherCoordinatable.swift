//
//  GatherCoordinatable.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 08.02.2022.
//

import CoreModels

@MainActor
public protocol GatherCoordinatable {
    func startGather(playersTeams: [Team: [Player]])
}

@MainActor
struct EmptyGatherCoordinator: GatherCoordinatable {
    func startGather(playersTeams: [Team: [Player]]) {}
}
