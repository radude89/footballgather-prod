//
//  NotificationPermissionGranterTests.swift
//  
//
//  Created by Radu Dan on 15.03.2022.
//

import XCTest
@testable import Gather

final class NotificationPermissionGranterTests: XCTestCase {
    
    func testAskForPermissions_whenAuthStatusIsNotDetermined_requestsAuthorization() async {
        var sut = makeSUT()
        
        await sut.askForPermissions()
        
        XCTAssertTrue(sut.hasGrantedPermissions)
    }
    
    func testAskForPermissions_whenHasAuthError_requestsAuthorization() async {
        var sut = makeSUT(authError: .unknown)
        
        await sut.askForPermissions()
        
        XCTAssertFalse(sut.hasGrantedPermissions)
    }
    
    func testHasGrantedPermissions_whenRequestErrorIsNil_isTrue() async {
        XCTAssertTrue(makeSUT().hasGrantedPermissions)
    }
    
    // MARK: - Helpers
    private func makeSUT(
        authorizationStatus: UNAuthorizationStatus = .notDetermined,
        authError: NotificationRequestError? = nil
    ) -> NotificationPermissionGranter {
        let center = Mocks.NotificationCenter(
            authorizationStatus: authorizationStatus,
            authError: authError
        )
        let reader = NotificationAuthorizationStatusReader(
            notificationCenter: center
        )
        let resolver = NotificationAuthorizationResolver(statusReader: reader)
        let requestHandler = NotificationAuthorizationRequestHandler(
            center: center,
            options: []
        )
        
        return NotificationPermissionGranter(
            resolver: resolver,
            requestHandler: requestHandler
        )
    }
    
}
