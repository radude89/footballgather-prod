//
//  NotificationAuthorizationStatusReader.swift
//  
//
//  Created by Radu Dan on 25.02.2022.
//

import NotificationCenter

protocol NotificationAuthorizationStatusReadable {
    var authorizationStatus: UNAuthorizationStatus { get async }
}

struct NotificationAuthorizationStatusReader {
    private let notificationCenter: NotificationCenter
    
    init(
        notificationCenter: NotificationCenter = UNUserNotificationCenter.current()
    ) {
        self.notificationCenter = notificationCenter
    }
}

extension NotificationAuthorizationStatusReader: NotificationAuthorizationStatusReadable {
    var authorizationStatus: UNAuthorizationStatus {
        get async {
            await notificationCenter.authorizationStatus
        }
    }
}
