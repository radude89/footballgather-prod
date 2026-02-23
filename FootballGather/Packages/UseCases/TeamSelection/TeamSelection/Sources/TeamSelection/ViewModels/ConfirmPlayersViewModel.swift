//
//  ConfirmPlayersViewModel.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 26.10.2021.
//

import Foundation
import CoreModels

@MainActor
struct ConfirmPlayersViewModel {

    private(set) var playersTeams: [Team: [Player]]

    let teams = Team.allCases

    init(players: [Player]) {
        playersTeams = [:]
        playersTeams[.bench] = players
    }

    var startGatherIsEnabled: Bool {
        playersTeams[.teamA]?.isEmpty == false &&
        playersTeams[.teamB]?.isEmpty == false
    }

    mutating func move(_ player: Player, to destinationTeam: Team) {
        for (team, players) in playersTeams {
            if let index = players.firstIndex(of: player) {
                playersTeams[team]?.remove(at: index)
                break
            }
        }
        if playersTeams[destinationTeam] != nil {
            playersTeams[destinationTeam]?.append(player)
        } else {
            playersTeams[destinationTeam] = [player]
        }
    }

}
