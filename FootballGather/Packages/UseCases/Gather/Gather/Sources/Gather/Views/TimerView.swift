//
//  TimerView.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 08.12.2021.
//

import SwiftUI
import GatherAssets

struct TimerView: View {
    
    @Environment(\.scenePhase) private var scenePhase
    @Environment(TimeSettings.self) private var timeSettings

    @Bindable private var viewModel: TimerViewModel
    private let setTimeAction: () -> Void
    
    init(viewModel: TimerViewModel, setTimeAction: @escaping () -> Void) {
        self.viewModel = viewModel
        self.setTimeAction = setTimeAction
    }
    
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
                .accessibilityID(AccessibilityID.setTimeButton)
        }
        .padding(.bottom)
        .alert(LocalizedString.timeIsUpTitle, isPresented: $viewModel.timeIsUp) {
            Button(LocalizedString.ok, role: .cancel) {}
        }
        .onChange(of: scenePhase, { _, newValue in
            Task {
                await viewModel.onScenePhaseChanged(to: newValue)
            }
        })
        .task { await viewModel.askForNotificationPermissions() }
    }
    
    private var cancelTimerButton: some View {
        Button(
            LocalizedString.cancel,
            action: viewModel.cancelTimer
        )
            .disabled(!viewModel.cancelButtonIsEnabled)
            .accessibilityID(AccessibilityID.cancelButton)
            .accessibilityLabel(LocalizedString.cancelTimerLabel)
    }
    
    private var timeView: some View {
        Text("\(viewModel.formattedTime)")
            .accessibilityID(AccessibilityID.timerView)
            .accessibilityAddTraits(.updatesFrequently)
    }
    
    private var actionTimerButton: some View {
        Button(
            viewModel.actionButtonTitle,
            action: viewModel.onActionTimer
        )
            .accessibilityID(AccessibilityID.actionTimerButton)
            .accessibilityLabel(viewModel.actionButtonAccessibilityLabel)
    }
    
}

// MARK: - Preview

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(viewModel: .init(timeSettings: .init())) {}
    }
}
