//
//  NotificationAuthorizationStatusReaderTests.swift
//  
//
//  Created by Radu Dan on 25.02.2022.
//

import XCTest
@testable import Gather

final class NotificationAuthorizationStatusReaderTests: XCTestCase {
    
    func testAuthorizationStatus() async {
        let statuses: [UNAuthorizationStatus] = [
            .notDetermined,
            .provisional,
            .denied,
            .ephemeral,
            .authorized
        ]
        
        for status in statuses {
            let center = Mocks.NotificationCenter(authorizationStatus: status)
            let sut = NotificationAuthorizationStatusReader(
                notificationCenter: center
            )
            
            let authorizationStatus = await sut.authorizationStatus
            
            XCTAssertEqual(authorizationStatus, status)
        }
    }
    
}
