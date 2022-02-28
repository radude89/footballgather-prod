//
//  NotificationScheduler.swift
//  
//
//  Created by Radu Dan on 28.02.2022.
//

import UserNotifications

struct NotificationScheduler {
    private let center: Gather.NotificationCenter
    private let statusReader: NotificationAuthorizationStatusReader
    private let options: UNAuthorizationOptions
    
    init(
        center: Gather.NotificationCenter = UNUserNotificationCenter.current(),
        options: UNAuthorizationOptions = [.alert, .sound, .provisional]
    ) {
        self.center = center
        self.options = options
        
        statusReader = NotificationAuthorizationStatusReader(
            notificationCenter: center
        )
    }
    
    func scheduleNotification(
        content: NotificationContent
    ) async -> NotificationRequestError? {
        if let error = await resolveAuthStatus(), error != .notDetermined {
            return error
        }
        
        if let error = await requestAuthorization() {
            return error
        }
        
        if let error = await addNotificationRequest(with: content) {
            return error
        }
        
        return nil
    }
    
    private func resolveAuthStatus() async -> NotificationRequestError? {
        return await NotificationAuthorizationResolver(
            statusReader: statusReader
        )
            .resolveAuthStatus()
    }
    
    private func requestAuthorization() async -> NotificationRequestError? {
        return await NotificationAuthorizationRequestHandler(
            center: center,
            options: options
        )
            .requestAuthorization()
    }
    
    private func addNotificationRequest(
        with content: NotificationContent
    ) async -> NotificationRequestError? {
        return await NotificationAddRequestHandler(center: center)
            .addNotificationRequest(content: content)
    }
}
