//
//  HistoryViewModel.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 14.01.2022.
//

import CoreModels

struct HistoryViewModel {
    private let storage: AppStorage
    
    init(storage: AppStorage) {
        self.storage = storage
    }
    
    var gathers: [Gather] {
        storage.gathers
    }
    
    var hasGathers: Bool {
        gathers.isEmpty
    }
    
    func scoreDescription(for gather: Gather) -> String {
        gather.score
    }
    
    func teamAPlayersDescription(for gather: Gather) -> String {
        formattedTeamDescription(for: gather.teamAPlayers)
    }
    
    func teamBPlayersDescription(for gather: Gather) -> String {
        formattedTeamDescription(for: gather.teamBPlayers)
    }
    
    private func formattedTeamDescription(for players: [Player]) -> String {
        players
            .map { $0.name }
            .joined(separator: ", ")
    }
}
