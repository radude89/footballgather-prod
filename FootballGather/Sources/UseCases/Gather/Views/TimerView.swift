//
//  TimerView.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 08.12.2021.
//

import SwiftUI
import Localizable

struct TimerView: View {
    
    @ObservedObject var viewModel: TimerViewModel
    
    var body: some View {
        HStack(spacing: 50) {
            cancelTimerButton
            timeView
            actionTimerButton
        }
        .padding()
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

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(viewModel: .init(remainingTimeInSeconds: 5))
    }
}
