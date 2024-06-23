//
//  TimerViewModelBackgroundTests.swift
//  
//
//  Created by Radu Dan on 15.03.2022.
//

import XCTest
import GatherAssets
@testable import Gather

final class TimerViewModelBackgroundTests: XCTestCase {
    
    @MainActor
    func testAskForNotificationPermissions() async {
        let granter = Mocks.NotificationPermissionGranter(
            hasGrantedPermissions: true
        )
        let sut = makeSUT(granter: granter)
        
        await sut.askForNotificationPermissions()
        
        XCTAssertTrue(granter.askForPermissionsCalled)
    }
    
    @MainActor
    func testOnScenePhaseChanged_toBackground_schedulesNotification() async {
        let sut = makeSUT()
        let sceneChangeDelegate = Mocks.TimerSceneChangeHandlerDelegate(
            timerIsRunning: true
        )
        sut.sceneChangeHandler = TimerSceneChangeHandler(
            delegate: sceneChangeDelegate
        )
        
        await sut.onScenePhaseChanged(to: .background)
        
        XCTAssertTrue(sceneChangeDelegate.scheduleNotificationCalled)
    }
    
    @MainActor
    func testOnScenePhaseChanged_toActive_cancelsNotification() async {
        let sut = makeSUT()
        let sceneChangeDelegate = Mocks.TimerSceneChangeHandlerDelegate(
            timerIsRunning: true
        )
        sut.sceneChangeHandler = TimerSceneChangeHandler(
            delegate: sceneChangeDelegate
        )
        await sut.onScenePhaseChanged(to: .background)
        
        await sut.onScenePhaseChanged(to: .active)
        
        XCTAssertTrue(sceneChangeDelegate.scheduleNotificationCalled)
    }
    
    func testUpdateRemainingTime_decrementsRemainingTimeInSeconds() {
        let timeSettings = TimeSettings()
        timeSettings.remainingTimeInSeconds = 10
        let sut = makeSUT(timeSettings: timeSettings)
        
        sut.updateRemainingTime(accumulatedRunningTime: 5)
        
        XCTAssertEqual(sut.remainingTimeInSeconds, 5)
    }
    
    func testScheduleNotification_whenHasGrantedPermissions_schedulesNotification() async throws {
        let center = Mocks.NotificationCenter(
            authorizationStatus: .authorized
        )
        let sut = makeSUT(center: center)
        
        await sut.scheduleNotification()
        
        let lastRequest = try XCTUnwrap(center.request)
        let content = lastRequest.content
        XCTAssertFalse(lastRequest.identifier.isEmpty)
        XCTAssertFalse(content.title.isEmpty)
        XCTAssertFalse(content.subtitle.isEmpty)
        XCTAssertNotNil(content.sound)
    }
    
    func testScheduleNotification_whenHasNotGrantedPermissions_returns() async {
        let center = Mocks.NotificationCenter(
            authorizationStatus: .denied
        )
        let sut = makeSUT(
            center: center,
            granter: .init(hasGrantedPermissions: false)
        )
        
        await sut.scheduleNotification()
        
        XCTAssertNil(center.request)
    }
    
    func testCancelNotifications() {
        let center = Mocks.NotificationCenter(
            authorizationStatus: .authorized
        )
        
        makeSUT(center: center).cancelNotifications()
        
        XCTAssertTrue(center.removeAllPendingNotificationRequestsCalled)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(
        center: Mocks.NotificationCenter = .init(
            authorizationStatus: .authorized
        ),
        granter: Mocks.NotificationPermissionGranter = .init(hasGrantedPermissions: true),
        timerController: Mocks.TimerController = .init(),
        timeSettings: TimeSettings = .init()
    ) -> TimerViewModel {
        .init(
            timerController: timerController,
            timeSettings: timeSettings,
            notificationPermissionGranter: granter,
            notificationScheduler: NotificationScheduler(center: center)
        )
    }
    
}
