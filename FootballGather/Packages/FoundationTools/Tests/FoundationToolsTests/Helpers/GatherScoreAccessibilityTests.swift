//
//  GatherScoreAccessibilityTests.swift
//  
//
//  Created by Radu Dan on 03.12.2021.
//

import XCTest
import CoreModels
import Localizable
@testable import FoundationTools

final class GatherScoreAccessibilityTests: XCTestCase {
    
    func testViewID() {
        Team.allCases.forEach { team in
            let accessibilityIDs: [AccessibilityID] = [
                .scoreLabel, .scoreHeader, .scoreStepper
            ]
            accessibilityIDs.forEach { accessibilityID in
                let viewAccessibilityID = GatherScoreAccessibility
                    .viewID(for: team, accessibilityID: accessibilityID)
                let expectedID = GatherScoreAccessibility
                    .makeAccessibilityID(
                        for: team, accessibilityID: accessibilityID
                    )
                
                XCTAssertEqual(viewAccessibilityID, expectedID)
            }
        }
    }
    
    func testScoreLabelID() {
        Team.allCases.forEach { team in
            let accessibilityID = GatherScoreAccessibility
                .scoreLabelID(for: team)
            let expectedID = GatherScoreAccessibility
                .makeAccessibilityID(for: team, accessibilityID: .scoreLabel)
            
            XCTAssertEqual(accessibilityID, expectedID)
        }
    }
    
    func testScoreHeaderID() {
        Team.allCases.forEach { team in
            let accessibilityID = GatherScoreAccessibility
                .scoreHeaderID(for: team)
            let expectedID = GatherScoreAccessibility
                .makeAccessibilityID(for: team, accessibilityID: .scoreHeader)
            
            XCTAssertEqual(accessibilityID, expectedID)
        }
    }
    
    func testScoreStepperID() {
        Team.allCases.forEach { team in
            let accessibilityID = GatherScoreAccessibility
                .scoreStepperID(for: team)
            let expectedID = GatherScoreAccessibility
                .makeAccessibilityID(for: team, accessibilityID: .scoreStepper)
            
            XCTAssertEqual(accessibilityID, expectedID)
        }
    }
    
}
