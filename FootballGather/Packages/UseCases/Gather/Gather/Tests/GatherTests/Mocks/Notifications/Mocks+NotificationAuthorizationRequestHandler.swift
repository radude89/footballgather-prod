//
//  Mocks+NotificationAuthorizationRequestHandler.swift
//  
//
//  Created by Radu Dan on 21.03.2022.
//

import Foundation
@testable import Gather

extension Mocks {
    struct NotificationAuthorizationRequester: NotificationAuthorizationRequestable {
        private let error: NotificationRequestError?
        
        init(error: NotificationRequestError? = nil) {
            self.error = error
        }
        
        func requestAuthorization() async -> NotificationRequestError? {
            error
        }
    }
}
