//
//  Mocks+NotificationPermissionGranter.swift
//  
//
//  Created by Radu Dan on 21.03.2022.
//

import NotificationCenter
@testable import Gather

extension Mocks {
    static func makeNotificationPermissionGranter(
        authorizationStatus: UNAuthorizationStatus = .notDetermined,
        authError: NotificationRequestError? = nil
    ) -> NotificationPermissionGranter {
        let center = Mocks.NotificationCenter(
            authorizationStatus: authorizationStatus,
            authError: authError
        )
        let reader = NotificationAuthorizationStatusReader(
            notificationCenter: center
        )
        let resolver = NotificationAuthorizationResolver(statusReader: reader)
        let requestHandler = NotificationAuthorizationRequestHandler(
            center: center,
            options: []
        )
        
        return NotificationPermissionGranter(
            resolver: resolver,
            requestHandler: requestHandler
        )
    }
}
