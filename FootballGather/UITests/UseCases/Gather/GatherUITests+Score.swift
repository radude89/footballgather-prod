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
    /// **AND** the score of one of my team is the maximum score allowed by the app
    /// **WHEN** I press "+"
    /// **THEN** the score stays at the maximum score
    func testUpdateScore() {
        [Team.teamA, Team.teamB].forEach { team in
            let scoreViewAsserter = ScoreViewAsserter(team: team, app: app)
            scoreViewAsserter.assertScoreViewIsPresented()
            
            var scoreAsserter = ScoreHandlerAsserter(team: team, app: app)
            scoreAsserter.assertScoreUpdatesCorrectly()
        }
    }
    
}
