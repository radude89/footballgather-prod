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

struct NotificationPermissionGranter: NotificationPermissionGrantable {
    private let resolver: NotificationAuthorizationResolver
    private let requestHandler: NotificationAuthorizationRequestHandler
    private var requestError: NotificationRequestError?
    
    init(resolver: NotificationAuthorizationResolver = .init(),
         requestHandler: NotificationAuthorizationRequestHandler = .init()) {
        self.resolver = resolver
        self.requestHandler = requestHandler
    }
    
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
