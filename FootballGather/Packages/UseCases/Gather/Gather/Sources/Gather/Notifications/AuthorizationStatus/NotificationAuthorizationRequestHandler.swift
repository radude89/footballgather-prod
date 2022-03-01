//
//  NotificationAuthorizationRequestHandler.swift
//  
//
//  Created by Radu Dan on 28.02.2022.
//

import UserNotifications

struct NotificationAuthorizationRequestHandler {
    private let center: Gather.NotificationCenter
    private let options: UNAuthorizationOptions
    
    init(
        center: Gather.NotificationCenter = UNUserNotificationCenter.current(),
        options: UNAuthorizationOptions = [.alert, .sound, .provisional]
    ) {
        self.center = center
        self.options = options
    }
    
    func requestAuthorization() async -> NotificationRequestError? {
        do {
            guard try await center.requestAuthorization(
                options: options
            ) else {
                throw NotificationRequestError.notGranted
            }
            
            return nil
        } catch {
            return .notGranted
        }
    }
}