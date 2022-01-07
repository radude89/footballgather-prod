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
    
    @Binding var selectedMinutes: String
    @Binding var selectedSeconds: String
    
    private let timeIntervals: TimeIntervals
    private let initialTime: (minutes: String, seconds: String)
    
    init(
        timeIntervals: TimeIntervals = .init(),
        selectedMinutes: Binding<String> = .constant("10"),
        selectedSeconds: Binding<String> = .constant("00")
    ) {
        self.timeIntervals = timeIntervals
        
        _selectedMinutes = selectedMinutes
        _selectedSeconds = selectedSeconds
        
        initialTime = (
            minutes: selectedMinutes.wrappedValue,
            seconds: selectedSeconds.wrappedValue
        )
    }
    
    var shouldEnableDone: Bool {
        initialTime.minutes != selectedMinutes ||
        initialTime.seconds != selectedSeconds
    }
    
    func makeDataSource() -> TwoComponentsPickerViewDataSource {
        .init(
            (
                first: .init(
                    values: Self.formattedTime(from: timeIntervals.minutes),
                    name: LocalizedString.minutes,
                    accessibilityID: .minutesPickerView,
                    selectedValue: $selectedMinutes
                ),
                second: .init(
                    values: Self.formattedTime(from: timeIntervals.seconds),
                    name: LocalizedString.seconds,
                    accessibilityID: .secondsPickerView,
                    selectedValue: $selectedSeconds
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
