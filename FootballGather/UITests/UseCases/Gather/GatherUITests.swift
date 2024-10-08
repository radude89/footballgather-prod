//
//  GatherUITests.swift.swift
//  UITests
//
//  Created by Radu Dan on 23.11.2021.
//

import XCTest
import CoreModels
import GatherAssets
import FoundationTools

final class GatherUITests: UITestCase, @unchecked Sendable {
    
    private var navigator: AppNavigator!
    
    override func setUp() async throws {
        try await super.setUp()
        
        await addUIInterruptionMonitor()
        
        await launchApp(populatingStorage: true)
        
        navigator = await .init(app: app, testCase: self)
        await navigator.presentGatherView()
    }
    
    @MainActor
    private func addUIInterruptionMonitor() {
        addUIInterruptionMonitor(
            withDescription: "Notification alert") { [weak self] alert in
                return self?.handleAlertPermissions(alert) ?? false
            }
    }
    
    @MainActor
    private func handleAlertPermissions(_ alert: XCUIElement) -> Bool {
        let notifPermission = "Would Like to Send You Notifications"
        guard alert.labelContains(text: notifPermission) else {
            return false
        }
        
        let allowButton = alert.buttons.element(boundBy: 1)
        if allowButton.exists {
            allowButton.tap()
            return true
        }
        
        return false
    }
    
    @MainActor
    func assertTime(
        is formattedTime: String,
        state: TimerState,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        XCTAssertTrue(
            app.staticTexts[formattedTime].waitToAppear(),
            file: file,
            line: line
        )
        
        assertTimerState(is: state, file: file, line: line)
    }
    
    @MainActor
    func assertTimerState(
        is state: TimerState,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        switch state {
        case .started:
            assertActionTimerButtonTitle(
                is: LocalizedString.pauseTimerLabel,
                file: file,
                line: line
            )
        case .paused:
            assertActionTimerButtonTitle(
                is: LocalizedString.resumeTimerLabel,
                file: file,
                line: line
            )
        case .stopped:
            assertActionTimerButtonTitle(
                is: LocalizedString.startTimerLabel,
                isEnabled: false,
                file: file,
                line: line
            )
        }
    }
    
    @MainActor
    func assertActionTimerButtonTitle(
        is title: String,
        isEnabled: Bool = true,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        XCTAssertEqual(
            actionTimerButton.label, title,
            file: file, line: line
        )
        
        XCTAssertEqual(
            cancelTimerButton.isEnabled, isEnabled,
            file: file, line: line
        )
    }
    
    @MainActor
    var cancelTimerButton: XCUIElement {
        app.buttons[GatherAssets.AccessibilityID.cancelButton]
    }
    
    @MainActor
    var actionTimerButton: XCUIElement {
        app.buttons[.actionTimerButton]
    }
    
}
