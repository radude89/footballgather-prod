//
//  NotificationRequestError.swift
//  
//
//  Created by Radu Dan on 28.02.2022.
//

import Foundation

enum NotificationRequestError: Error {
    case unknown
    case notDetermined
    case denied
    case notGranted
    case unableToAddRequest
}

extension NotificationRequestError: CaseIterable {}
