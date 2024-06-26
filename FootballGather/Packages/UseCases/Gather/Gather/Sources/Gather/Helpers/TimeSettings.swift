//
//  TimeSettings.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 11.01.2022.
//

import SwiftUI
import FoundationTools

@Observable
final class TimeSettings {
    var remainingTimeInSeconds = GatherDefaultTime.value()
}
