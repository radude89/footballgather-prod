//
//  NotificationCenter.swift
//  
//
//  Created by Radu Dan on 28.02.2022.
//

import UserNotifications

protocol NotificationCenter {
    var authorizationStatus: UNAuthorizationStatus { get async }
    
    func requestAuthorization(
        options: UNAuthorizationOptions
    ) async throws -> Bool
    
    func add(_ request: UNNotificationRequest) async throws
}

extension UNUserNotificationCenter: NotificationCenter {
    var authorizationStatus: UNAuthorizationStatus {
        get async {
            await notificationSettings().authorizationStatus
        }
    }
}
