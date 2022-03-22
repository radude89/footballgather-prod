//
//  NotificationPermissionGranterIntegrationTests.swift
//  
//
//  Created by Radu Dan on 21.03.2022.
//

import XCTest
@testable import Gather

final class NotificationPermissionGranterIntegrationTests: XCTestCase {
    
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
        Mocks.makeNotificationPermissionGranter(
            authorizationStatus: authorizationStatus,
            authError: authError
        )
    }
    
}
