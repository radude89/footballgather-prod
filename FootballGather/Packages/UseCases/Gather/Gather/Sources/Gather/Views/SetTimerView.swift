//
//  SetTimerView.swift
//  FootballGather (iOS)
//
//  Created by Radu Dan on 17.12.2021.
//

import SwiftUI
import UITools
import GatherAssets

struct SetTimerView: View {
    
    @State private var selectedMinutes: String
    @State private var selectedSeconds: String
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var timeSettings: TimeSettings
    
    private let viewModel: SetTimerViewModel
    
    init(
        selectedMinutes: String = "10",
        selectedSeconds: String = "00"
    ) {
        _selectedMinutes = State(initialValue: selectedMinutes)
        _selectedSeconds = State(initialValue: selectedSeconds)
        
        viewModel = .init(
            selectedMinutes: selectedMinutes,
            selectedSeconds: selectedSeconds
        )
    }
    
    var body: some View {
        NavigationStack {
            TwoComponentsPickerView(dataSource: makeDataSource())
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(LocalizedString.cancel, action: { dismiss() })
                            .accessibilityID(AccessibilityID.cancelButton)
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(LocalizedString.done, action: onSave)
                            .disabled(!doneButtonIsEnabled)
                            .accessibilityID(AccessibilityID.doneButton)
                    }
                }
        }
        .accessibilityID(AccessibilityID.setTimeView)
    }
    
    private func makeDataSource() -> TwoComponentsPickerViewDataSource {
        .init(
            (
                first: .init(
                    values: viewModel.formattedMinutes,
                    name: LocalizedString.minutes,
                    accessibilityID: AccessibilityID.minutesPickerView.rawValue,
                    selectedValue: $selectedMinutes
                ),
                second: .init(
                    values: viewModel.formattedSeconds,
                    name: LocalizedString.seconds,
                    accessibilityID: AccessibilityID.secondsPickerView.rawValue,
                    selectedValue: $selectedSeconds
                )
            )
        )
    }
    
    private var doneButtonIsEnabled: Bool {
        viewModel.doneButtonIsEnabled(
            minutes: selectedMinutes,
            seconds: selectedSeconds
        )
    }
    
    private func onSave() {
        timeSettings.remainingTimeInSeconds = viewModel
            .remainingTimeInSeconds(
                fromMinutes: selectedMinutes,
                seconds: selectedSeconds
            )
        dismiss()
    }
    
}

// MARK: - Preview

struct SetTimerView_Previews: PreviewProvider {
    static var previews: some View {
        SetTimerView()
    }
}
