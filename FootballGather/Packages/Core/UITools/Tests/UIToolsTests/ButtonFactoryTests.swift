//
//  ButtonFactoryTests.swift
//  
//
//  Created by Radu Dan on 12.11.2021.
//

import XCTest
import Localizable
@testable import UITools

final class ButtonFactoryTests: XCTestCase {
    
    func testMakeSystemButton() {
        let buttonTitle = "Title"
        let accessibilityID = AccessibilityID.startGatherButton
        let accessibilityLabel = "Accessibility Label"
        let accessibilityHint = "Accessibility Hint"
        
        let sut = ButtonFactory.makeSystemButton(
            title: buttonTitle,
            isEnabled: false,
            accessibilityID: accessibilityID,
            accessibilityLabel: accessibilityLabel,
            accessibilityHint: accessibilityHint,
            selector: #selector(dummyAction)
        )
        
        XCTAssertEqual(sut.buttonType, .system)
        XCTAssertFalse(sut.translatesAutoresizingMaskIntoConstraints)
        XCTAssertEqual(sut.title(for: .normal), buttonTitle)
        XCTAssertFalse(sut.isEnabled)
        XCTAssertEqual(sut.accessibilityIdentifier, accessibilityID.rawValue)
        XCTAssertEqual(sut.accessibilityLabel, accessibilityLabel)
        XCTAssertEqual(sut.accessibilityHint, accessibilityHint)
        
        let actions = sut.actions(forTarget: nil, forControlEvent: .touchUpInside)
        XCTAssertEqual(actions?.count, 1)
        XCTAssertEqual(
            actions?.first,
            #selector(dummyAction).description
        )
    }
    
    @objc private func dummyAction() {}
    
}
