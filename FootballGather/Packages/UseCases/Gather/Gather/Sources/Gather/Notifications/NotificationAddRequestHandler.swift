//
//  NotificationAddRequestHandler.swift
//  
//
//  Created by Radu Dan on 28.02.2022.
//

import UserNotifications

struct NotificationAddRequestHandler {
    private let center: Gather.NotificationCenter
    
    init(center: Gather.NotificationCenter = UNUserNotificationCenter.current()) {
        self.center = center
    }
    
    func addNotificationRequest(
        content: NotificationContent
    ) async -> NotificationRequestError? {
        do {
            try await center.add(makeNotificationRequest(with: content))
            return nil
        } catch {
            return .unableToAddRequest
        }
    }
    
    private func makeNotificationRequest(
        with content: NotificationContent
    ) -> UNNotificationRequest {
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: content.triggerInterval,
            repeats: content.repeats
        )
        
        return .init(
            identifier: content.id.uuidString,
            content: content.unNotificationContent,
            trigger: trigger
        )
    }
}
