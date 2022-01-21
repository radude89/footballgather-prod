//
//  HistoryViewModel+Accessibility.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 21.01.2022.
//

import Foundation
import CoreModels
import Localizable

extension HistoryViewModel {
    
    struct AccessibilityHandler {
        private let gather: Gather
        
        private let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            return formatter
        }()
        
        init(gather: Gather) {
            self.gather = gather
        }
        
        var accessibilityLabel: String {
            String(
                format: LocalizedString.gatherAllAccessibilityLabel,
                completedAtDescription,
                resultTeamsDescription,
                playersDescription(gather.teamAPlayers, from: .teamA),
                playersDescription(gather.teamBPlayers, from: .teamB)
            )
        }
        
        private var completedAtDescription: String {
            dateFormatter.string(from: gather.completedAt)
        }
        
        private var resultTeamsDescription: String {
            let splittedScore = gather.score.components(separatedBy: ":")
            
            guard let teamAScore = Int(splittedScore[0]),
                  let teamBScore = Int(splittedScore[1]) else {
                      return ""
                  }
            
            return scoreDescription(teamAScore: teamAScore, teamBScore: teamBScore)
        }
        
        private func scoreDescription(teamAScore: Int, teamBScore: Int) -> String {
            if teamAScore > teamBScore {
                return winningTeamDescription(.teamA)
            } else if teamAScore < teamBScore {
                return winningTeamDescription(.teamB)
            }
            
            return LocalizedString.gatherDraw
        }
        
        private func winningTeamDescription(_ team: Team) -> String {
            String(
                format: LocalizedString.gatherWinningTeam,
                team.name
            )
        }
        
        private func playersDescription(_ players: [Player], from team: Team) -> String {
            String(
                format: LocalizedString.gatherPlayersInTeam,
                team.name,
                players.map(\.name).joined(separator: ", ")
            )
        }
    }
    
}
