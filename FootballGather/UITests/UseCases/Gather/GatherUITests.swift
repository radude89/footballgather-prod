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

final class GatherUITests: UITestCase {
    
    private var navigator: AppNavigator!
    
    override func setUp() {
        super.setUp()
        
        navigator = .init(app: app, testCase: self)
        
        launchApp(populatingStorage: true)
        navigator.presentGatherView()
    }
    
    func assertTime(
        is formattedTime: String,
        state: TimerState,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        XCTAssertTrue(
            app.staticTexts[formattedTime].waitToAppear(),
            file: file,
            line: line
        )
        
        assertTimerState(is: state, file: file, line: line)
    }
    
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
    
    func assertActionTimerButtonTitle(
        is title: String,
        isEnabled: Bool = true,
        file: StaticString = #file,
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
    
    var cancelTimerButton: XCUIElement {
        app.buttons[GatherAssets.AccessibilityID.cancelButton]
    }
    
    var actionTimerButton: XCUIElement {
        app.buttons[.actionTimerButton]
    }
    
}
