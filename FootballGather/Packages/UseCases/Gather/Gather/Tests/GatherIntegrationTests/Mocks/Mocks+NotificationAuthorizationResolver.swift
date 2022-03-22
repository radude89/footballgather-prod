//
//  Mocks+NotificationAuthorizationResolver.swift
//  
//
//  Created by Radu Dan on 21.03.2022.
//

import NotificationCenter
@testable import Gather

extension Mocks {
    static func makeNotificationAuthorizationResolver(
        authorizationStatus: UNAuthorizationStatus
    ) -> NotificationAuthorizationResolver {
        let center = Mocks.NotificationCenter(
            authorizationStatus: authorizationStatus
        )
        let reader = NotificationAuthorizationStatusReader(
            notificationCenter: center
        )
        
        return NotificationAuthorizationResolver(statusReader: reader)
    }
}
