//
//  TimerViewModel+Background.swift
//  
//
//  Created by Radu Dan on 09.03.2022.
//

import SwiftUI
import GatherAssets

extension TimerViewModel: TimerSceneChangeHandlerDelegate {
    @MainActor
    func askForNotificationPermissions() async {
        await notificationPermissionGranter.askForPermissions()
    }
    
    @MainActor
    func onScenePhaseChanged(to newState: ScenePhase) async {
        await sceneChangeHandler.onScenePhaseChanged(to: newState)
    }
    
    func updateRemainingTime(accumulatedRunningTime: Int) {
        remainingTimeInSeconds -= accumulatedRunningTime
    }
    
    func scheduleNotification() async {
        guard notificationPermissionGranter.hasGrantedPermissions else {
            return
        }
        
        _ = await notificationScheduler.scheduleNotification(
            content: .init(
                title: LocalizedString.timeIsUpTitle,
                message: LocalizedString.timeIsUpMessage,
                triggerInterval: Double(remainingTimeInSeconds)
            )
        )
    }
    
    func cancelNotifications() {
        notificationScheduler.cancelPendingNotifications()
    }
}
