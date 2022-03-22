//
//  Mocks+NotificationAuthorizationResolver.swift
//  
//
//  Created by Radu Dan on 21.03.2022.
//

import Foundation
@testable import Gather

extension Mocks {
    struct NotificationAuthorizationResolver: NotificationAuthorizationResolvable {
        private let error: NotificationRequestError?
        
        init(error: NotificationRequestError? = nil) {
            self.error = error
        }
        
        func resolveAuthStatus() async -> NotificationRequestError? {
            error
        }
    }
}
