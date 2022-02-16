//
//  AccessibilityTests.swift
//  
//
//  Created by Radu Dan on 03.12.2021.
//

import XCTest
import CoreModels
import Localizable
@testable import FoundationTools

final class AccessibilityTests: XCTestCase {
    
    func testViewID() {
        Team.allCases.forEach { team in
            let accessibilityIDs: [AccessibilityID] = [
                .scoreLabel, .scoreHeader, .scoreStepper
            ]
            accessibilityIDs.forEach { accessibilityID in
                let viewAccessibilityID = ScoreAccessibility
                    .viewID(for: team, accessibilityID: accessibilityID)
                let expectedID = ScoreAccessibility
                    .makeAccessibilityID(
                        for: team, accessibilityID: accessibilityID
                    )
                
                XCTAssertEqual(viewAccessibilityID, expectedID)
            }
        }
    }
    
    func testScoreLabelID() {
        Team.allCases.forEach { team in
            let accessibilityID = ScoreAccessibility
                .scoreLabelID(for: team)
            let expectedID = ScoreAccessibility
                .makeAccessibilityID(for: team, accessibilityID: .scoreLabel)
            
            XCTAssertEqual(accessibilityID, expectedID)
        }
    }
    
    func testScoreHeaderID() {
        Team.allCases.forEach { team in
            let accessibilityID = ScoreAccessibility
                .scoreHeaderID(for: team)
            let expectedID = ScoreAccessibility
                .makeAccessibilityID(for: team, accessibilityID: .scoreHeader)
            
            XCTAssertEqual(accessibilityID, expectedID)
        }
    }
    
    func testScoreStepperID() {
        Team.allCases.forEach { team in
            let accessibilityID = ScoreAccessibility
                .scoreStepperID(for: team)
            let expectedID = ScoreAccessibility
                .makeAccessibilityID(for: team, accessibilityID: .scoreStepper)
            
            XCTAssertEqual(accessibilityID, expectedID)
        }
    }
    
}
