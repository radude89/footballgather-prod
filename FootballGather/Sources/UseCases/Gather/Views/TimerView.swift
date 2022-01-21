//
//  TimerView.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 08.12.2021.
//

import SwiftUI
import Localizable

struct TimerView: View {
    
    @EnvironmentObject var timeSettings: TimeSettings
    @ObservedObject var viewModel: TimerViewModel
    
    var setTimeAction: () -> Void
    
    var body: some View {
        VStack {
            HStack(spacing: 50) {
                cancelTimerButton
                timeView
                actionTimerButton
            }
            .padding()
            
            Button(LocalizedString.setTime, action: setTimeAction)
                .disabled(viewModel.timerIsRunning)
                .accessibilityID(.setTimeButton)
        }
        .padding(.bottom)
        .alert(LocalizedString.timeIsUpTitle, isPresented: $viewModel.timeIsUp) {
            Button(LocalizedString.ok, role: .cancel) {}
        }
    }
    
    private var cancelTimerButton: some View {
        Button(
            LocalizedString.cancel,
            action: viewModel.cancelTimer
        )
            .disabled(!viewModel.cancelButtonIsEnabled)
            .accessibilityID(.cancelButton)
            .accessibilityLabel(LocalizedString.cancelTimerLabel)
    }
    
    private var timeView: some View {
        Text("\(viewModel.formattedTime)")
            .accessibilityID(.timerView)
            .accessibilityAddTraits(.updatesFrequently)
    }
    
    private var actionTimerButton: some View {
        Button(
            viewModel.actionButtonTitle,
            action: viewModel.onActionTimer
        )
            .accessibilityID(.actionTimerButton)
            .accessibilityLabel(viewModel.actionButtonAccessibilityLabel)
    }
    
}

// MARK: - Preview

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(viewModel: .init(timeSettings: .init())) {}
    }
}
