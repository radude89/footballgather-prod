//
//  ScoreHandler.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 01.12.2021.
//

import CoreModels
import FoundationTools

protocol ScoreHandling {
    func score(for team: Team) -> Int
    mutating func incrementScore(for team: Team)
    mutating func decrementScore(for team: Team)
}

struct ScoreHandler {
    private var score: [Team: Int]
    private let maxScore: Int
    
    init(
        score: [Team: Int] = [:],
        maxScore: Int = GatherMaxScore.value()
    ) {
        self.score = score
        self.maxScore = maxScore
    }
}

extension ScoreHandler: ScoreHandling {
    func score(for team: Team) -> Int {
        guard let score = score[team] else {
            return 0
        }
        
        return score
    }
    
    mutating func incrementScore(for team: Team) {
        var newScore = score[team] ?? 0
        
        guard newScore < maxScore else {
            return
        }
        
        newScore += 1
        score[team] = newScore
    }
    
    mutating func decrementScore(for team: Team) {
        var newScore = score[team] ?? 0
        
        guard newScore > 0 else {
            return
        }
        
        newScore -= 1
        score[team] = newScore
    }
}
