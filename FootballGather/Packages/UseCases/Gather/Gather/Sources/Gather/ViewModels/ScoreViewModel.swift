//
//  ScoreViewModel.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 02.12.2021.
//

import SwiftUI
import CoreModels
import GatherAssets

final class ScoreViewModel: ObservableObject {
    
    @Published var teamAScore: Int
    @Published var teamBScore: Int
    
    private var scoreHandler: ScoreHandler
    
    init(scoreHandler: ScoreHandler = .init()) {
        self.scoreHandler = scoreHandler
        teamAScore = scoreHandler.score(for: .teamA)
        teamBScore = scoreHandler.score(for: .teamB)
    }
    
    func headerTitle(for team: Team) -> String {
        team.name.uppercased()
    }
    
    var formattedScore: String {
        let teamAScore = formattedScore(for: .teamA)
        let teamBScore = formattedScore(for: .teamB)
        return "\(teamAScore):\(teamBScore)"
    }
    
    func scoreViewAccessibilityLabel(for team: Team) -> String {
        String(
            format: LocalizedString.gatherScoreAccessibilityLabel,
            team.name,
            formattedScore(for: team)
        )
    }
    
    func formattedScore(for team: Team) -> String {
        "\(scoreHandler.score(for: team))"
    }
    
    func onIncrementScore(for team: Team) {
        scoreHandler.incrementScore(for: team)
        updateScore(for: team, increment: true)
    }
    
    func onDecrementScore(for team: Team) {
        scoreHandler.decrementScore(for: team)
        updateScore(for: team, increment: false)
    }
    
    private func updateScore(for team: Team, increment: Bool) {
        let value = increment ? 1 : -1
        
        switch team {
        case .teamA:
            teamAScore += value
        case .teamB:
            teamBScore += value
        default:
            break
        }
    }
    
}
