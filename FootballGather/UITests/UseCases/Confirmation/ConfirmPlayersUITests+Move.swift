//
//  ConfirmPlayersUITests+Move.swift
//  UITests
//
//  Created by Radu Dan on 16.11.2021.
//

import XCTest
import CoreModels

extension ConfirmPlayersUITests {
    
    /// **Scenario 2: Moving players**
    ///
    /// **GIVEN** I am in the "Confirmation" screen
    /// **WHEN** I move one of the rows
    /// **THEN** the player is moved to the desired section
    ///
    /// **Scenario 3: Enabling the "Start Gather" button**
    /// 
    /// **GIVEN** I am in the "Confirmation" screen
    /// **WHEN** I completed the action to move players
    /// **AND** I moved at least one player in each "TEAM A" and "TEAM B" section
    /// **THEN** the "Start Gather" button becomes ENABLED
    ///
    /// **Scenario 4: Disabling the "Start Gather" button**
    ///
    /// **GIVEN** I am in the "Confirmation" screen
    /// **WHEN** I completed the action to move players
    /// **AND** I HAVE NOT moved at least one player in each "TEAM A" and "TEAM B" section
    /// **THEN** the "Start Gather" button becomes DISABLED
    func testMovePlayers() {
        let startGatherButton = app.buttons[.startGatherButton]
        XCTAssertFalse(startGatherButton.isEnabled)
        
        move("John", to: .teamA)
        move("Jane", to: .teamB)
        
        assertPlayers(inTeam: .bench, haveNames: [])
        assertPlayers(inTeam: .teamA, haveNames: ["John"])
        assertPlayers(inTeam: .teamB, haveNames: ["Jane"])
        
        XCTAssertTrue(startGatherButton.isEnabled)
        
        move("John", to: .bench)
        XCTAssertFalse(startGatherButton.isEnabled)
    }
    
    private func move(_ playerName: String, to team: Team) {
        let sectionLabel = confirmTable.staticTexts[team.name.uppercased()]
        
        app.buttons["Reorder \(playerName)"]
            .press(forDuration: 0.3, thenDragTo: sectionLabel)
    }
    
    private func assertPlayers(
        inTeam team: Team,
        haveNames names: [String],
        line: UInt = #line
    ) {
        XCTAssertEqual(
            playersFinder.nameOfPlayers(inTeam: team),
            names,
            line: line
        )
    }
}
