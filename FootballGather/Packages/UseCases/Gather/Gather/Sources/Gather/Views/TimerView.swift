//
//  TimerView.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 08.12.2021.
//

import SwiftUI
import GatherAssets

struct TimerView: View {
    
    @EnvironmentObject var timeSettings: TimeSettings
    @ObservedObject var viewModel: TimerViewModel
    @Environment(\.scenePhase) private var scenePhase
    
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
                .accessibilityID(AccessibilityID.setTimeButton)
        }
        .padding(.bottom)
        .alert(LocalizedString.timeIsUpTitle, isPresented: $viewModel.timeIsUp) {
            Button(LocalizedString.ok, role: .cancel) {}
        }
        .onChange(of: scenePhase, perform: viewModel.onScenePhaseChanged)
        .onAppear {
            let notificationCenter = UNUserNotificationCenter.current()
            
            notificationCenter.getNotificationSettings(completionHandler: { (settings) in
                if settings.authorizationStatus == .notDetermined {
                    print("Notification permission has not been asked yet, go for it!")
                } else if settings.authorizationStatus == .denied {
                    print("Notification permission was previously denied, go to settings & privacy to re-enable")
                } else if settings.authorizationStatus == .authorized {
                    print("Notification permission was already granted")
                }
            })
            
            notificationCenter.requestAuthorization(options: [.alert, .sound]) { [notificationCenter] success, error in
                if success {
                    print("All set!")
                    let content = UNMutableNotificationContent()
                    content.title = "Feed the cat"
                    content.subtitle = "It looks hungry"
                    content.sound = .default

                    // show this notification five seconds from now
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

                    // choose a random identifier
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                    // add our notification request
                    notificationCenter.add(request)
//                    notificationCenter.removeAllPendingNotificationRequests()
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
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
