//
//  NotificationAuthorizationRequestHandlerTests.swift
//  
//
//  Created by Radu Dan on 01.03.2022.
//

import XCTest
@testable import Gather

final class NotificationAuthorizationRequestHandlerTests: XCTestCase {
    
    func testRequestAuthorization_whenHasDenied_isNotGrantedError() async {
        let sut = makeSUT(status: .denied)
        
        let response = await sut.requestAuthorization()
        
        XCTAssertEqual(response, .notGranted)
    }
    
    func testRequestAuthorization_whenHasAuthorized_isNil() async {
        let sut = makeSUT()
        
        let response = await sut.requestAuthorization()
        
        XCTAssertNil(response)
    }
    
    func testRequestAuthorization_whenError_isNotGranted() async {
        let sut = makeSUT(error: NotificationRequestError.unknown)
        
        let response = await sut.requestAuthorization()
        
        XCTAssertEqual(response, .notGranted)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        status: UNAuthorizationStatus = .authorized,
        error: Error? = nil,
        options: UNAuthorizationOptions = []
    ) -> NotificationAuthorizationRequestHandler {
        let center = Mocks.NotificationCenter(
            authorizationStatus: status,
            authError: error
        )
        
        return NotificationAuthorizationRequestHandler(
            center: center,
            options: options
        )
    }
    
}
