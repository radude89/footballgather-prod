//
//  Mocks+NotificationCenter.swift
//  
//
//  Created by Radu Dan on 21.03.2022.
//

import NotificationCenter
@testable import Gather

extension Mocks {
    
    final class NotificationCenter: Gather.NotificationCenter {
        
        private(set) var authorizationStatus: UNAuthorizationStatus
        private(set) var removeAllPendingNotificationRequestsCalled = false
        private(set) var request: UNNotificationRequest?
        
        private let authError: Error?
        private let addRequestError: Error?
        
        init(
            authorizationStatus: UNAuthorizationStatus,
            authError: Error? = nil,
            addRequestError: Error? = nil
        ) {
            self.authorizationStatus = authorizationStatus
            self.authError = authError
            self.addRequestError = addRequestError
        }
        
        func requestAuthorization(options: UNAuthorizationOptions) async throws -> Bool {
            if let error = authError {
                throw error
            }
            
            return authorizationStatus == .authorized || authorizationStatus == .notDetermined
        }
        
        func add(_ request: UNNotificationRequest) async throws {
            if let error = addRequestError {
                throw error
            }
            
            self.request = request
        }
        
        func removeAllPendingNotificationRequests() {
            removeAllPendingNotificationRequestsCalled = true
            request = nil
        }
        
    }
    
}
