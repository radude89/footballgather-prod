//
//  HistoryViewModel.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 14.01.2022.
//

import CoreModels
import FoundationTools
import SwiftUI

@MainActor
public final class HistoryViewModel {

    private let storage: GatherStorageHandler
    
    public init(storage: GatherStorageHandler) {
        self.storage = storage
    }
    
    var gathers: [Gather] {
        storage.gathers.sorted { $0.completedAt > $1.completedAt }
    }
    
    var hasGathers: Bool {
        !gathers.isEmpty
    }
    
    func scoreDescription(for gather: Gather) -> String {
        gather.score
    }
    
    func accessibilityLabel(for gather: Gather) -> String {
        AccessibilityHandler(gather: gather).accessibilityLabel
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
