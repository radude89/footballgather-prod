//
//  GatherDefaultTime.swift
//  
//
//  Created by Radu Dan on 13.12.2021.
//

import Foundation

public struct GatherDefaultTime {
    private static let inSeconds = 600
    
    public static let inSecondsWhenIsRunningUITests = 2
    
    public static func value(
        isRunningUITests: Bool = CommandLineHandler().isRunningUITests
    ) -> Int {
        if isRunningUITests {
            return inSecondsWhenIsRunningUITests
        }
        
        return inSeconds
    }
}
