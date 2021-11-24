//
//  ConfirmPlayersViewModel.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 26.10.2021.
//

import CoreModels
import Localizable
import Foundation

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
    
    var numberOfSections: Int {
        teams.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        guard let team = Team(rawValue: section) else {
            return 0
        }
        
        return playersTeams[team]?.count ?? 0
    }
    
    func titleForHeaderInSection(_ section: Int) -> String? {
        Team(rawValue: section)?.name.uppercased()
    }
    
    func rowTitle(at indexPath: IndexPath) -> String? {
        guard let team = Team(rawValue: indexPath.section),
              let players = playersTeams[team],
              0 ..< players.count ~= indexPath.row else {
                  return nil
              }
        
        return players[indexPath.row].name
    }
    
    mutating func move(
        from source: IndexPath,
        to destination: IndexPath
    ) {
        guard let sourceTeam = Team(rawValue: source.section),
              let sourcePlayers = playersTeams[sourceTeam],
              0 ..< sourcePlayers.count ~= source.row,
              destination.row >= 0,
              let destinationTeam = Team(rawValue: destination.section) else {
                  return
              }
        
        removePlayer(from: sourceTeam, at: source.row)
        
        insertPlayer(
            sourcePlayers[source.row],
            in: destinationTeam,
            at: destination.row
        )
    }
    
    private mutating func removePlayer(from team: Team, at index: Int) {
        playersTeams[team]?.remove(at: index)
    }
    
    private mutating func insertPlayer(
        _ player: Player,
        in team: Team,
        at index: Int
    ) {
        if playersTeams[team]?.isEmpty == false {
            playersTeams[team]?.insert(player, at: index)
        } else {
            playersTeams[team] = [player]
        }
    }
    
}
