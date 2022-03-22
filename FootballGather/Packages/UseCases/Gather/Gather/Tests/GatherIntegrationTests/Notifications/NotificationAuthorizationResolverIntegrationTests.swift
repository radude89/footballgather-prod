//
//  NotificationAuthorizationResolverIntegrationTests.swift
//  
//
//  Created by Radu Dan on 21.03.2022.
//

import XCTest
@testable import Gather

final class NotificationAuthorizationResolverIntegrationTests: XCTestCase {
    
    func testResolveStatus_whenCenterReturnsAuthorized_isNil() async {
        let sut = makeSUT()
        
        let status = await sut.resolveAuthStatus()
        
        XCTAssertNil(status)
    }
    
    func testResolveStatus_whenCenterReturnsProvisional_isNil() async {
        let sut = makeSUT(authorizationStatus: .provisional)
        
        let status = await sut.resolveAuthStatus()
        
        XCTAssertNil(status)
    }
    
    func testResolveStatus_whenCenterReturnsEphemeral_isNil() async {
        let sut = makeSUT(authorizationStatus: .ephemeral)
        
        let status = await sut.resolveAuthStatus()
        
        XCTAssertNil(status)
    }
    
    func testResolveStatus_whenCenterReturnsDenied_isDenied() async {
        let sut = makeSUT(authorizationStatus: .denied)
        
        let status = await sut.resolveAuthStatus()
        
        XCTAssertEqual(status, .denied)
    }
    
    func testResolveStatus_whenCenterReturnsNotDetermined_isNotDetermined() async {
        let sut = makeSUT(authorizationStatus: .notDetermined)
        
        let status = await sut.resolveAuthStatus()
        
        XCTAssertEqual(status, .notDetermined)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        authorizationStatus: UNAuthorizationStatus = .authorized
    ) -> NotificationAuthorizationResolver {
        Mocks.makeNotificationAuthorizationResolver(
            authorizationStatus: authorizationStatus
        )
    }
    
}
