//
//  NotificationSchedulerTests.swift
//  
//
//  Created by Radu Dan on 01.03.2022.
//

import XCTest
@testable import Gather

final class NotificationSchedulerTests: XCTestCase {
    
    private let notificationContent = NotificationContent(
        title: "Test title",
        message: "Test message",
        triggerInterval: 0.01
    )
    
    func testScheduleNotification_returnsNil() async {
        let sut = makeSUT()
        
        let response = await sut.scheduleNotification(
            content: notificationContent
        )
        
        XCTAssertNil(response)
    }
    
    func testScheduleNotification_whenResolveAuthStatusIsNotDetermined_returnsNil() async {
        let sut = makeSUT(status: .notDetermined)
        
        let response = await sut.scheduleNotification(
            content: notificationContent
        )
        
        XCTAssertNil(response)
    }
    
    func testScheduleNotification_whenAddNotificationRequestHasError_isUnableToAddRequest() async {
        let sut = makeSUT(
            addRequestError: NotificationRequestError.unknown
        )
        
        let response = await sut.scheduleNotification(
            content: notificationContent
        )
        
        XCTAssertEqual(response, .unableToAddRequest)
    }
    
    func testCancelPendingNotifications_removesAllPendingNotificationRequests() {
        let center = Mocks.NotificationCenter(
            authorizationStatus: .authorized
        )
        let sut = NotificationScheduler(center: center)
        
        sut.cancelPendingNotifications()
        
        XCTAssertTrue(center.removeAllPendingNotificationRequestsCalled)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        status: UNAuthorizationStatus = .authorized,
        addRequestError: Error? = nil
    ) -> NotificationScheduler {
        let center = Mocks.NotificationCenter(
            authorizationStatus: status,
            addRequestError: addRequestError
        )
        
        return NotificationScheduler(center: center)
    }
    
}
