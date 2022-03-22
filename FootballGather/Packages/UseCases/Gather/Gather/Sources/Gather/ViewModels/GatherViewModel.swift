//
//  GatherViewModel.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 29.11.2021.
//

import CoreModels
import FoundationTools

public struct GatherViewModel {
    let playersTeams: [Team: [Player]]
    
    public init(playersTeams: [Team: [Player]]) {
        self.playersTeams = playersTeams
    }
    
    func formattedTime(
        from settings: TimeSettings
    ) -> (minutes: String, seconds: String) {
        let time = GatherTimeFormatter(
            seconds: settings.remainingTimeInSeconds
        )
            .formattedTime
            .components(separatedBy: ":")
        
        return (time[0], time[1])
    }
    
    func storeGather(score: String, storage: GatherStorageHandler) {
        let gather = Gather(
            score: score,
            teamAPlayers: playersTeams[.teamA] ?? [],
            teamBPlayers: playersTeams[.teamB] ?? []
        )
        storage.addGather(gather)
    }
}
