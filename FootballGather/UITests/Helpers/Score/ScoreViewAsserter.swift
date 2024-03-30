//
//  ScoreViewAsserter.swift
//  UITests
//
//  Created by Radu Dan on 03.12.2021.
//

import XCTest
import CoreModels
import GatherAssets
import FoundationTools

@MainActor
struct ScoreViewAsserter {
    private let team: Team
    private let app: XCUIApplication
    
    init(team: Team, app: XCUIApplication) {
        self.team = team
        self.app = app
    }
    
    func assertScoreViewIsPresented(file: StaticString = #file, line: UInt = #line) {
        assertScoreHeaderExists(file: file, line: line)
        assertScoreLabelExists(file: file, line: line)
        assertScoreStepperExists(file: file, line: line)
    }
    
    // MARK: - Private methods
    
    private func assertScoreHeaderExists(
        file: StaticString = #file,
        line: UInt = #line
    ) {
        assertView(
            havingID: GatherAssets.AccessibilityID.scoreHeader.rawValue,
            existsForTeam: team,
            elementsToSearchIn: app.staticTexts,
            file: file,
            line: line
        )
    }
    
    private func assertView(
        havingID id: String,
        existsForTeam team: Team,
        elementsToSearchIn elements: XCUIElementQuery,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        let accessibilityID = ScoreAccessibility.viewID(
            for: team,
            accessibilityID: id
        )
        XCTAssertTrue(elements[accessibilityID].exists, file: file, line: line)
    }
    
    private func assertScoreLabelExists(
        file: StaticString = #file,
        line: UInt = #line
    ) {
        assertView(
            havingID: GatherAssets.AccessibilityID.scoreLabel.rawValue,
            existsForTeam: team,
            elementsToSearchIn: app.staticTexts,
            file: file,
            line: line
        )
    }
    
    private func assertScoreStepperExists(
        file: StaticString = #file,
        line: UInt = #line
    ) {
        assertView(
            havingID: GatherAssets.AccessibilityID.scoreStepper.rawValue,
            existsForTeam: team,
            elementsToSearchIn: app.steppers,
            file: file,
            line: line
        )
    }
}
