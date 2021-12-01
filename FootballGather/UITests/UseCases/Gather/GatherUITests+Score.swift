//
//  GatherUITests+Score.swift
//  UITests
//
//  Created by Radu Dan on 01.12.2021.
//

import XCTest
import CoreModels
import FoundationTools

extension GatherUITests {
    
    /// **Scenario 1: Updating the score**
    ///
    /// **GIVEN** I am in the "Gather" screen
    /// **WHEN** I press "+" or "-"
    /// **THEN** the score is incremented or decremented
    ///
    /// **Scenario 2: Minimum score**
    ///
    /// **GIVEN** I am in the "Gather" screen
    /// **AND** the score of one of my team is "0"
    /// **WHEN** I press "-"
    /// **THEN** the score stays at "0"
    ///
    /// **Scenario 3: Maximum score**
    ///
    /// **GIVEN** I am in the "Gather" screen
    /// **AND** the score of one of my team is "99"
    /// **WHEN** I press "+"
    /// **THEN** the score stays at "99"
    func testUpdateScore() throws {
        XCTAssertTrue(app.otherElements[.scoreView].exists)
        
        try [Team.teamA, Team.teamB].forEach { team in
            let score = try XCTUnwrap(scoreLabel(for: team))
            XCTAssertEqual(score.label, "0")
            
            let scoreIncrementer = try XCTUnwrap(incrementer(for: team))
            scoreIncrementer.tap()
            
            XCTAssertEqual(score.label, "1")
            
            let scoreDecrementer = try XCTUnwrap(decrementer(for: team))
            scoreDecrementer.tap()
            
            XCTAssertEqual(score.label, "0")
            
            scoreDecrementer.tap()
            XCTAssertEqual(score.label, "0")
            
            (1...GatherScore.maxValue).forEach { index in
                scoreIncrementer.tap()
                XCTAssertEqual(score.label, "\(index)")
            }
            
            XCTAssertEqual(score.label, "\(GatherScore.maxValue)")
            
            scoreIncrementer.tap()
            XCTAssertEqual(score.label, "\(GatherScore.maxValue)")
        }
    }
    
    private func scoreLabel(for team: Team) -> XCUIElement? {
        switch team {
        case .bench:
            return nil
        case .teamA:
            return app.staticTexts[.teamAScoreLabel]
        case .teamB:
            return app.staticTexts[.teamBScoreLabel]
        }
    }
    
    private func incrementer(for team: Team) -> XCUIElement? {
        switch team {
        case .bench:
            return nil
        case .teamA:
            return app.buttons[.teamAScoreIncrement]
        case .teamB:
            return app.buttons[.teamBScoreIncrement]
        }
    }
    
    private func decrementer(for team: Team) -> XCUIElement? {
        switch team {
        case .bench:
            return nil
        case .teamA:
            return app.buttons[.teamAScoreDecrement]
        case .teamB:
            return app.buttons[.teamBScoreDecrement]
        }
    }
    
}
