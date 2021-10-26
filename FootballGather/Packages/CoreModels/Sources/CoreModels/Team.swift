//
//  Team.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 26.10.2021.
//

import Foundation

public enum Team: String {
    case bench, teamA, teamB
}

extension Team: CaseIterable {}

extension Team {
    public var name: String {
        switch self {
        case .bench:
            return "Bench"
        case .teamA:
            return "Team A"
        case .teamB:
            return "Team B"
        }
    }
}
