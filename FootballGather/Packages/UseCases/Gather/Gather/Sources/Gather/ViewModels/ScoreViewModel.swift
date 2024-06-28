//
//  ScoreViewModel.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 02.12.2021.
//

import SwiftUI
import CoreModels
import GatherAssets

@Observable
@MainActor
final class ScoreViewModel {
    
    private(set) var teamAScore: Int
    private(set) var teamBScore: Int
    
    private var scoreHandler: ScoreHandling
    
    init(scoreHandler: ScoreHandling = ScoreHandler()) {
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
        updateScore(for: team)
    }
    
    func onDecrementScore(for team: Team) {
        scoreHandler.decrementScore(for: team)
        updateScore(for: team)
    }
    
    private func updateScore(for team: Team) {
        switch team {
        case .teamA:
            teamAScore = scoreHandler.score(for: .teamA)
        case .teamB:
            teamBScore = scoreHandler.score(for: .teamB)
        default:
            break
        }
    }
}
