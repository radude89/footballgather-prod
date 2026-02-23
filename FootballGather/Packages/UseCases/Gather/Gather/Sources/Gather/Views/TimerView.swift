//
//  TimerView.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 08.12.2021.
//

import SwiftUI
import GatherAssets
import UITools

struct TimerView: View {
    
    @Environment(\.scenePhase) private var scenePhase
    @Environment(TimeSettings.self) private var timeSettings
    @Environment(\.colorScheme) private var colorScheme
    
    @Bindable private var viewModel: TimerViewModel
    private let setTimeAction: () -> Void
    private let endGatherAction: () -> Void
    
    init(
        viewModel: TimerViewModel,
        setTimeAction: @escaping () -> Void,
        endGatherAction: @escaping () -> Void
    ) {
        self.viewModel = viewModel
        self.setTimeAction = setTimeAction
        self.endGatherAction = endGatherAction
    }
    
    var body: some View {
        VStack(spacing: 16) {
            timeView
            
            HStack(spacing: 16) {
                cancelTimerButton
                actionTimerButton
            }
            
            Button(action: setTimeAction) {
                Label(LocalizedString.setTime, systemImage: "clock.badge.checkmark")
                    .padding(.all, 8)
            }
            .disabled(viewModel.timerIsRunning)
            .buttonStyle(.glass)
            .grayscale(viewModel.timerIsRunning ? 1.0 : 0.0)
            .foregroundStyle(viewModel.timerIsRunning ? .tertiary : .primary)
            .accessibilityID(AccessibilityID.setTimeButton)
        }
        .padding(20)
        .background {
            RoundedRectangle(cornerRadius: 24)
                .fill(.background)
        }
        .glassEffect(.regular, in: .rect(cornerRadius: 24))
        .alert(LocalizedString.timeIsUpTitle, isPresented: $viewModel.timeIsUp) {
            Button(LocalizedString.endGather) {
                endGatherAction()
            }
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
        GlassIconButton(
            icon: "stop.circle.fill",
            tint: .red,
            padding: 8,
            bottomPadding: 0,
            accessibilityID: AccessibilityID.cancelButton.rawValue,
            accessibilityLabel: LocalizedString.cancelTimerLabel,
            action: viewModel.cancelTimer
        )
        .disabled(!viewModel.cancelButtonIsEnabled)
    }
    
    private var timeView: some View {
        Text("\(viewModel.formattedTime)")
            .font(.system(size: 56, weight: .semibold, design: .monospaced))
            .foregroundStyle(foregroundColor)
            .padding(.horizontal, 32)
            .padding(.vertical, 20)
            .background {
                Capsule()
                    .fill(backgroundColor)
            }
            .glassEffect(.regular, in: .capsule)
            .accessibilityID(AccessibilityID.timerView)
            .accessibilityAddTraits(.updatesFrequently)
    }
    
    private var actionTimerButton: some View {
        GlassIconButton(
            icon: viewModel.timerIsRunning ? "pause.circle.fill" : "play.circle.fill",
            tint: viewModel.timerIsRunning ? .cyan : .green,
            padding: 8,
            bottomPadding: 0,
            accessibilityID: AccessibilityID.actionTimerButton.rawValue,
            accessibilityLabel: viewModel.actionButtonAccessibilityLabel,
            action: viewModel.onActionTimer
        )
    }
    
    private var foregroundColor: Color {
        colorScheme == .dark ? .black : .white
    }
    
    private var backgroundColor: Color {
        colorScheme == .dark ? .white : .black
    }
    
}

#Preview("Timer - Stopped") {
    TimerView(
        viewModel: TimerViewModel(timeSettings: TimeSettings(remainingTimeInSeconds: 3600)),
        setTimeAction: {},
        endGatherAction: {}
    )
    .environment(TimeSettings(remainingTimeInSeconds: 3600))
    .padding()
}

#Preview("Timer - Running") {
    let viewModel = TimerViewModel(timeSettings: TimeSettings(remainingTimeInSeconds: 1800))
    let timeSettings = TimeSettings(remainingTimeInSeconds: 1800)
    
    return TimerView(
        viewModel: viewModel,
        setTimeAction: {},
        endGatherAction: {}
    )
    .environment(timeSettings)
    .padding()
    .onAppear {
        viewModel.startTimer()
    }
}
#Preview("Timer - Paused") {
    let viewModel = TimerViewModel(timeSettings: TimeSettings(remainingTimeInSeconds: 1200))
    let timeSettings = TimeSettings(remainingTimeInSeconds: 1200)
    
    return TimerView(
        viewModel: viewModel,
        setTimeAction: {},
        endGatherAction: {}
    )
    .environment(timeSettings)
    .padding()
    .onAppear {
        viewModel.startTimer()
        viewModel.pauseTimer()
    }
}
