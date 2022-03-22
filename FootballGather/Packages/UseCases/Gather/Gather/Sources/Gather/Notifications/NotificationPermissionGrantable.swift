//
//  NotificationPermissionGrantable.swift
//  
//
//  Created by Radu Dan on 09.03.2022.
//

import Foundation

protocol NotificationPermissionGrantable {
    var hasGrantedPermissions: Bool { get }
    
    mutating func askForPermissions() async
}

struct NotificationPermissionGranter {
    private let resolver: NotificationAuthorizationResolvable
    private let requestHandler: NotificationAuthorizationRequestable
    private var requestError: NotificationRequestError?
    
    init(
        resolver: NotificationAuthorizationResolvable = NotificationAuthorizationResolver(),
         requestHandler: NotificationAuthorizationRequestable = NotificationAuthorizationRequestHandler()
    ) {
        self.resolver = resolver
        self.requestHandler = requestHandler
    }
}

extension NotificationPermissionGranter: NotificationPermissionGrantable {
    mutating func askForPermissions() async {
        let authStatus = await resolver.resolveAuthStatus()
        if authStatus == .notDetermined {
            requestError = await requestHandler.requestAuthorization()
        } else {
            requestError = authStatus
        }
    }
    
    var hasGrantedPermissions: Bool {
        requestError == nil
    }
}
