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

    var remainingTimeInSeconds: Int {
        didSet {
            onRemainingTimeInSecondsChanged?(remainingTimeInSeconds)
        }
    }

    @ObservationIgnored
    let onRemainingTimeInSecondsChanged: ((Int) -> Void)?
    
    init(
        remainingTimeInSeconds: Int = GatherDefaultTime.value(),
        onRemainingTimeInSecondsChanged: ((Int) -> Void)? = nil
    ) {
        self.remainingTimeInSeconds = remainingTimeInSeconds
        self.onRemainingTimeInSecondsChanged = onRemainingTimeInSecondsChanged
    }

}
