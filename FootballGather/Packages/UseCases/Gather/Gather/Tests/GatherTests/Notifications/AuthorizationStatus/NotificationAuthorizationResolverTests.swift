//
//  NotificationAuthorizationResolverTests.swift
//  
//
//  Created by Radu Dan on 01.03.2022.
//

import XCTest
@testable import Gather

final class NotificationAuthorizationResolverTests: XCTestCase {
    
    func testResolveAuthStatus_whenAuthStatusIsAuthorized_isNil() async {
        let sut = makeSUT(status: .authorized)
        
        let status = await sut.resolveAuthStatus()
        
        XCTAssertNil(status)
    }
    
    func testResolveAuthStatus_whenAuthStatusIsProvisional_isNil() async {
        let sut = makeSUT(status: .provisional)
        
        let status = await sut.resolveAuthStatus()
        
        XCTAssertNil(status)
    }
    
    func testResolveAuthStatus_whenAuthStatusIsEphemeral_isNil() async {
        let sut = makeSUT(status: .ephemeral)
        
        let status = await sut.resolveAuthStatus()
        
        XCTAssertNil(status)
    }
    
    func testResolveAuthStatus_whenAuthStatusIsDenied_isDenied() async {
        let sut = makeSUT(status: .denied)
        
        let status = await sut.resolveAuthStatus()
        
        XCTAssertEqual(status, .denied)
    }
    
    func testResolveAuthStatus_whenAuthStatusIsNotDetermined_isNotDetermined() async {
        let sut = makeSUT(status: .notDetermined)
        
        let status = await sut.resolveAuthStatus()
        
        XCTAssertEqual(status, .notDetermined)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        status: UNAuthorizationStatus
    ) -> NotificationAuthorizationResolver {
        let center = Mocks.NotificationCenter(
            authorizationStatus: status
        )
        let statusReader = NotificationAuthorizationStatusReader(
            notificationCenter: center
        )
        
        return NotificationAuthorizationResolver(
            statusReader: statusReader
        )
    }
    
}
