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
    
    func testScheduleNotification_whenResolveAuthStatusIsDenied_returnsError() async {
        let sut = makeSUT(status: .denied)
        
        let response = await sut.scheduleNotification(
            content: notificationContent
        )
        
        XCTAssertEqual(response, .denied)
    }
    
    func testScheduleNotification_whenResolveAuthStatusIsNotDetermined_returnsNil() async {
        let sut = makeSUT(status: .notDetermined)
        
        let response = await sut.scheduleNotification(
            content: notificationContent
        )
        
        XCTAssertNil(response)
    }
    
    func testScheduleNotification_whenRequestAuthorizationHasError_isNotGranted() async {
        let sut = makeSUT(authError: NotificationRequestError.unknown)
        
        let response = await sut.scheduleNotification(
            content: notificationContent
        )
        
        XCTAssertEqual(response, .notGranted)
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
    
    // MARK: - Helpers
    
    private func makeSUT(
        status: UNAuthorizationStatus = .authorized,
        options: UNAuthorizationOptions = [],
        authError: Error? = nil,
        addRequestError: Error? = nil
    ) -> NotificationScheduler {
        let center = Mocks.NotificationCenter(
            authorizationStatus: status,
            authError: authError,
            addRequestError: addRequestError
        )
        
        return NotificationScheduler(center: center, options: options)
    }
    
}
