//
//  NotificationScheduler.swift
//  
//
//  Created by Radu Dan on 28.02.2022.
//

import UserNotifications

struct NotificationScheduler {
    private let center: Gather.NotificationCenter
    
    init(center: Gather.NotificationCenter = UNUserNotificationCenter.current()) {
        self.center = center
    }
    
    func cancelPendingNotifications() {
        center.removeAllPendingNotificationRequests()
    }
    
    func scheduleNotification(
        content: NotificationContent
    ) async -> NotificationRequestError? {
        if let error = await addNotificationRequest(with: content) {
            return error
        }
        
        return nil
    }
    
    private func addNotificationRequest(
        with content: NotificationContent
    ) async -> NotificationRequestError? {
        return await NotificationAddRequestHandler(center: center)
            .addNotificationRequest(content: content)
    }
}
