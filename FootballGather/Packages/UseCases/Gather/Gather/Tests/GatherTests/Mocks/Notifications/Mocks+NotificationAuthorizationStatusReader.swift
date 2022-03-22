//
//  Mocks+NotificationAuthorizationStatusReader.swift
//  
//
//  Created by Radu Dan on 21.03.2022.
//

import NotificationCenter
@testable import Gather

extension Mocks {
    struct NotificationAuthorizationStatusReader: NotificationAuthorizationStatusReadable {
        private(set) var authorizationStatus: UNAuthorizationStatus
        
        init(authorizationStatus: UNAuthorizationStatus) {
            self.authorizationStatus = authorizationStatus
        }
    }
}
