//
//  Mocks+NotificationPermissionGranter.swift
//  
//
//  Created by Radu Dan on 21.03.2022.
//

import Foundation
@testable import Gather

extension Mocks {
    
    final class NotificationPermissionGranter: NotificationPermissionGrantable {
        
        private(set) var hasGrantedPermissions: Bool
        private(set) var askForPermissionsCalled = false
        
        init(hasGrantedPermissions: Bool = true) {
            self.hasGrantedPermissions = hasGrantedPermissions
        }
        
        func askForPermissions() async {
            askForPermissionsCalled = true
        }
        
    }
    
}
