//
//  GatherMaxScore.swift
//  
//
//  Created by Radu Dan on 01.12.2021.
//

import Foundation

public enum GatherMaxScore {
    private static let maxScore = 99
    
    public static let maxScoreWhenIsRunningUITests = 3
    
    public static func value(
        isRunningUITests: Bool = CommandLineHandler().isRunningUITests
    ) -> Int {
        if isRunningUITests {
            return maxScoreWhenIsRunningUITests
        }
        
        return maxScore
    }
}
