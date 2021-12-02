//
//  GatherScoreHandler.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 01.12.2021.
//

import CoreModels
import FoundationTools

struct GatherScoreHandler {
    private var score: [Team: Int]
    private let maxScore: Int
    
    init(score: [Team: Int] = [:], maxScore: Int = GatherScore.maxValue) {
        self.score = score
        self.maxScore = maxScore
    }
    
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
