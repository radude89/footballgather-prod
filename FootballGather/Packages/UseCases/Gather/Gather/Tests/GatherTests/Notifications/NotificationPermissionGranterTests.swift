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
        var sut = makeSUT(resolveError: .notDetermined)
        
        await sut.askForPermissions()
        
        XCTAssertTrue(sut.hasGrantedPermissions)
    }
    
    func testAskForPermissions_whenHasAuthError_requestsAuthorization() async {
        var sut = makeSUT(resolveError: .unknown)
        
        await sut.askForPermissions()
        
        XCTAssertFalse(sut.hasGrantedPermissions)
    }
    
    func testHasGrantedPermissions_whenRequestErrorIsNil_isTrue() async {
        XCTAssertTrue(makeSUT().hasGrantedPermissions)
    }
    
    // MARK: - Helpers
    private func makeSUT(
        resolveError: NotificationRequestError? = nil,
        requestError: NotificationRequestError? = nil
    ) -> NotificationPermissionGranter {
        let resolver = Mocks.NotificationAuthorizationResolver(
            error: resolveError
        )
        let requestHandler = Mocks.NotificationAuthorizationRequester(
            error: requestError
        )
        
        return NotificationPermissionGranter(
            resolver: resolver,
            requestHandler: requestHandler
        )
    }
    
}
