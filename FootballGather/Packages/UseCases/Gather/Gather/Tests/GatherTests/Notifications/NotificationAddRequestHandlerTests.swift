//
//  NotificationAddRequestHandlerTests.swift
//  
//
//  Created by Radu Dan on 01.03.2022.
//

import XCTest
@testable import Gather

final class NotificationAddRequestHandlerTests: XCTestCase {
    
    private let notificationContent = NotificationContent(
        title: "Test",
        message: "Test",
        triggerInterval: 1
    )
    
    func testAddNotificationRequest_whenAddsToTheQueue_isNil() async {
        let sut = makeSUT()
        
        let response = await sut.addNotificationRequest(
            content: notificationContent
        )
        
        XCTAssertNil(response)
    }
    
    func testAddNotificationRequest_whenThrowsError_isUnableToAddRequestError() async {
        for error in NotificationRequestError.allCases {
            let sut = makeSUT(error: error)
            
            let response = await sut.addNotificationRequest(
                content: notificationContent
            )
            
            XCTAssertEqual(response, .unableToAddRequest)
        }
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        status: UNAuthorizationStatus = .authorized,
        error: Error? = nil
    ) -> NotificationAddRequestHandler {
        let center = Mocks.NotificationCenter(
            authorizationStatus: status,
            addRequestError: error
        )
        
        return NotificationAddRequestHandler(center: center)
    }
    
}
