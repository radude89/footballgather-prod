//
//  AccessibilityTests.swift
//  
//
//  Created by Radu Dan on 03.12.2021.
//

import XCTest
import CoreModels
@testable import FoundationTools

final class AccessibilityTests: XCTestCase {
    
    private enum AccessibilityID: String {
        case scoreLabel = "score.label"
        case scoreHeader = "score.header"
        case scoreStepper = "score.stepper"
    }
    
    func testViewID() {
        Team.allCases.forEach { team in
            let accessibilityIDs: [AccessibilityID] = [
                .scoreLabel, .scoreHeader, .scoreStepper
            ]
            accessibilityIDs.forEach { accessibilityID in
                let viewAccessibilityID = ScoreAccessibility
                    .viewID(for: team, accessibilityID: accessibilityID.rawValue)
                let expectedID = ScoreAccessibility
                    .makeAccessibilityID(
                        for: team, accessibilityID: accessibilityID.rawValue
                    )
                
                XCTAssertEqual(viewAccessibilityID, expectedID)
            }
        }
    }
    
    func testScoreLabelID() {
        Team.allCases.forEach { team in
            let accessibilityID = ScoreAccessibility
                .scoreLabelID(for: team, accessibilityID: AccessibilityID.scoreLabel.rawValue)
            let expectedID = ScoreAccessibility
                .makeAccessibilityID(for: team, accessibilityID: AccessibilityID.scoreLabel.rawValue)
            
            XCTAssertEqual(accessibilityID, expectedID)
        }
    }
    
    func testScoreHeaderID() {
        Team.allCases.forEach { team in
            let accessibilityID = ScoreAccessibility
                .scoreHeaderID(for: team, accessibilityID: AccessibilityID.scoreHeader.rawValue)
            let expectedID = ScoreAccessibility
                .makeAccessibilityID(for: team, accessibilityID: AccessibilityID.scoreHeader.rawValue)
            
            XCTAssertEqual(accessibilityID, expectedID)
        }
    }
    
    func testScoreStepperID() {
        Team.allCases.forEach { team in
            let accessibilityID = ScoreAccessibility
                .scoreStepperID(for: team, accessibilityID: AccessibilityID.scoreStepper.rawValue)
            let expectedID = ScoreAccessibility
                .makeAccessibilityID(for: team, accessibilityID: AccessibilityID.scoreStepper.rawValue)
            
            XCTAssertEqual(accessibilityID, expectedID)
        }
    }
    
}
