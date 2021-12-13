//
//  GatherTimeFormatter.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 13.12.2021.
//

import Foundation

struct GatherTimeFormatter {
    private let seconds: Int
    private let formatter: DateComponentsFormatter
    private static let allowedMaxTimeInSeconds = 5999
    
    init(
        seconds: Int = 0,
        formatter: DateComponentsFormatter = .init()
    ) {
        self.seconds = min(seconds, Self.allowedMaxTimeInSeconds)
        self.formatter = formatter
        
        configureFormatter()
    }
    
    private func configureFormatter() {
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        formatter.zeroFormattingBehavior = [.pad]
    }
    
    var formattedTime: String {
        formatter.string(from: Double(seconds))!
    }
}
