//
//  ScoreHandlerAsserter.swift
//  UITests
//
//  Created by Radu Dan on 03.12.2021.
//

import XCTest
import CoreModels
import FoundationTools
import GatherAssets

@MainActor
struct ScoreHandlerAsserter {
    private let team: Team
    private let app: XCUIApplication
    private var currentScore: Int
    private static let maxScore = GatherMaxScore.maxScoreWhenIsRunningUITests
    
    init(team: Team, app: XCUIApplication, currentScore: Int = 0) {
        self.team = team
        self.app = app
        self.currentScore = currentScore
    }
    
    mutating func assertScoreUpdatesCorrectly(
        file: StaticString = #file,
        line: UInt = #line
    ) {
        assertScoreCorrectlyIncrements(file: file, line: line)
        assertScoreCorrectlyDecrements(numberOfTimesToCheck: 2, file: file, line: line)
        assertScoreDoesNotIncrementMoreThanMaxValue(file: file, line: line)
    }
    
    // MARK: - Private methods
    
    private var stepper: XCUIElement {
        let stepperID = ScoreAccessibility.scoreStepperID(
            for: team,
            accessibilityID: GatherAssets.AccessibilityID.scoreStepper.rawValue
        )
        return app.steppers[stepperID]
    }
    
    private var scoreIncrementer: XCUIElement {
        stepper.buttons["Increment"]
    }
    
    private var scoreDecrementer: XCUIElement {
        stepper.buttons["Decrement"]
    }
    
    private var score: XCUIElement {
        let scoreLabelID = ScoreAccessibility.scoreLabelID(
            for: team,
            accessibilityID: GatherAssets.AccessibilityID.scoreLabel.rawValue
        )
        return app.staticTexts[scoreLabelID]
    }
    
    private mutating func assertScoreCorrectlyIncrements(
        file: StaticString = #file,
        line: UInt = #line
    ) {
        incrementScore()
        assertScoreIsCorrect(file: file, line: line)
    }
    
    private mutating func incrementScore() {
        scoreIncrementer.tap()
        currentScore += 1
        setScoreToMaxValueIfNeeded()
    }
    
    private mutating func setScoreToMaxValueIfNeeded() {
        if currentScore > Self.maxScore {
            currentScore = Self.maxScore
        }
    }
    
    private func assertScoreIsCorrect(file: StaticString = #filePath, line: UInt = #line) {
        XCTAssertEqual(score.label, "\(currentScore)", file: file, line: line)
    }

    private mutating func assertScoreCorrectlyDecrements(
        numberOfTimesToCheck: Int = 1,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        (0..<numberOfTimesToCheck).forEach { _ in
            decrementScore()
            assertScoreIsCorrect(file: file, line: line)
        }
    }
    
    private mutating func decrementScore() {
        scoreDecrementer.tap()
        currentScore -= 1
        resetScoreToZeroIfNeeded()
    }
    
    private mutating func resetScoreToZeroIfNeeded() {
        if currentScore < 0 {
            currentScore = 0
        }
    }
    
    private mutating func assertScoreDoesNotIncrementMoreThanMaxValue(
        file: StaticString = #file,
        line: UInt = #line
    ) {
        (1...Self.maxScore + 1).forEach { index in
            assertScoreCorrectlyIncrements(file: file, line: line)
        }
    }
}
