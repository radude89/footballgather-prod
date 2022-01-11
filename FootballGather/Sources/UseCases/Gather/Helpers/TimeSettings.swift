//
//  TimeSettings.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 11.01.2022.
//

import SwiftUI
import FoundationTools

final class TimeSettings: ObservableObject {
    @Published var remainingTimeInSeconds = GatherDefaultTime.value()
}
