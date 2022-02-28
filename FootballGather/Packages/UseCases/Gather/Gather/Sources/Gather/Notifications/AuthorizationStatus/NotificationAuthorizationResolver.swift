//
//  NotificationAuthorizationResolver.swift
//  
//
//  Created by Radu Dan on 28.02.2022.
//

import UserNotifications

struct NotificationAuthorizationResolver {
    private let statusReader: NotificationAuthorizationStatusReader
    
    init(statusReader: NotificationAuthorizationStatusReader) {
        self.statusReader = statusReader
    }
    
    func resolveAuthStatus() async -> NotificationRequestError? {
        let status = await statusReader.authorizationStatus
        
        if let error = checkNotificationStatus(status) {
            return error
        }
        
        return nil
    }
    
    private func checkNotificationStatus(
        _ status: UNAuthorizationStatus
    ) -> NotificationRequestError? {
        switch status {
        case .authorized, .provisional, .ephemeral:
            return nil
        case .denied:
            return .denied
        case .notDetermined:
            return .notDetermined
        @unknown default:
            return .unknown
        }
    }
}
