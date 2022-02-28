//
//  NotificationContent.swift
//  
//
//  Created by Radu Dan on 28.02.2022.
//

import UserNotifications

struct NotificationContent: Identifiable {
    let id: UUID
    let title: String
    let message: String
    let triggerInterval: TimeInterval
    let repeats: Bool
    let sound: UNNotificationSound
    
    init(
        id: UUID = .init(),
        title: String,
        message: String,
        triggerInterval: TimeInterval = 5,
        repeats: Bool = false,
        sound: UNNotificationSound = .default
    ) {
        self.id = id
        self.title = title
        self.message = message
        self.triggerInterval = triggerInterval
        self.repeats = repeats
        self.sound = sound
    }
    
    var unNotificationContent: UNNotificationContent {
        let notifContent = UNMutableNotificationContent()
        notifContent.title = title
        notifContent.subtitle = message
        notifContent.sound = sound
        return notifContent
    }
}
