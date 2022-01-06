//
//  SetTimerViewModel.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 22.12.2021.
//

import SwiftUI
import UITools
import Localizable

// MARK: - SetTimerViewModel

struct SetTimerViewModel {
    private let timeIntervals: TimeIntervals
    
    init(timeIntervals: TimeIntervals = .init()) {
        self.timeIntervals = timeIntervals
    }
    
    func makeDataSource(
        selectedMinutes: Binding<String>,
        selectedSeconds: Binding<String>
    ) -> TwoComponentsPickerViewDataSource {
        .init(
            (
                first: .init(
                    values: Self.formattedTime(from: timeIntervals.minutes),
                    name: LocalizedString.minutes,
                    accessibilityID: .minutesPickerView,
                    selectedValue: selectedMinutes
                ),
                second: .init(
                    values: Self.formattedTime(from: timeIntervals.seconds),
                    name: LocalizedString.seconds,
                    accessibilityID: .secondsPickerView,
                    selectedValue: selectedSeconds
                )
            )
        )
    }
}

// MARK: - TimeIntervals

extension SetTimerViewModel {
    struct TimeIntervals {
        let minutes: [Int]
        let seconds: [Int]
        
        init(
            minutes: [Int] = Array(0...90),
            seconds: [Int] = Array(1..<60)
        ) {
            self.minutes = minutes
            self.seconds = seconds
        }
    }
}

// MARK: - Time Formatter

extension SetTimerViewModel {
    static func formattedTime(from interval: [Int]) -> [String] {
        interval.map { $0 < 10 ? "0\($0)" : "\($0)"}
    }
}
