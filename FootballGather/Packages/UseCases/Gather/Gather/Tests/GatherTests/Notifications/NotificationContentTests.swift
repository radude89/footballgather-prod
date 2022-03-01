//
//  NotificationContentTests.swift
//  
//
//  Created by Radu Dan on 01.03.2022.
//

import XCTest
@testable import Gather

final class NotificationContentTests: XCTestCase {
    
    func testUserNotificationContent_setsTitleAndSubtitleAndSound() {
        let title = "Test title"
        let message = "Test message"
        let sut = NotificationContent(
            title: title,
            message: message,
            triggerInterval: 2,
            sound: .default
        )
        
        let unContent = sut.unNotificationContent
        
        XCTAssertEqual(unContent.title, title)
        XCTAssertEqual(unContent.subtitle, message)
        XCTAssertEqual(unContent.sound, .default)
    }
    
}
