//
//  SetTimerViewModel.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 22.12.2021.
//

import UITools
import FoundationTools

// MARK: - SetTimerViewModel

struct SetTimerViewModel {
    
    private let timeIntervals: TimeIntervals
    private let initialTime: (minutes: String, seconds: String)
    
    init(
        timeIntervals: TimeIntervals = .init(),
        selectedMinutes: String,
        selectedSeconds: String
    ) {
        self.timeIntervals = timeIntervals
        initialTime = (
            minutes: selectedMinutes,
            seconds: selectedSeconds
        )
    }
    
    var formattedMinutes: [String] {
        Self.formattedTime(from: timeIntervals.minutes)
    }
    
    var formattedSeconds: [String] {
        Self.formattedTime(from: timeIntervals.seconds)
    }
    
    private static func formattedTime(from interval: [Int]) -> [String] {
        interval.map { $0 < 10 ? "0\($0)" : "\($0)"}
    }
    
    func doneButtonIsEnabled(
        minutes: String,
        seconds: String
    ) -> Bool {
        initialTime.minutes != minutes ||
        initialTime.seconds != seconds
    }
    
    func remainingTimeInSeconds(
        fromMinutes minutes: String,
        seconds: String
    ) -> Int {
        guard let minutesAsInt = Int(minutes),
              let secondsAsInt = Int(seconds) else {
                  return 0
              }
        
        let totalTime = 60 * abs(minutesAsInt) + abs(secondsAsInt)
        
        return max(totalTime, GatherDefaultTime.minAllowedTimeInSeconds)
    }

}

// MARK: - TimeIntervals

extension SetTimerViewModel {
    struct TimeIntervals {
        let minutes: [Int]
        let seconds: [Int]
        
        init(
            minutes: [Int] = Array(0...90),
            seconds: [Int] = Array(0..<60)
        ) {
            self.minutes = minutes
            self.seconds = seconds
        }
    }
}
