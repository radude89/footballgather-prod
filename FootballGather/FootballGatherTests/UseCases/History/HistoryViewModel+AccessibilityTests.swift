//
//  HistoryViewModel+AccessibilityTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 21.01.2022.
//

import XCTest
import CoreModels
import Localizable
@testable import FootballGather

final class HistoryViewModelAccessibilityTests: XCTestCase {
    
    // MARK: - Variables
    
    private let winnerTeamAText = String(
        format: LocalizedString.gatherWinningTeam,
        Team.teamA.name
    )
    
    private let winnerTeamBText = String(
        format: LocalizedString.gatherWinningTeam,
        Team.teamB.name
    )
    
    private let drawText = LocalizedString.gatherDraw
    
    // MARK: - Tests
    
    func testAccessibilityLabel_whenEndedAsDraw_containsGatherDrawText() {
        let gather = Gather.demoGathers.first!
        let sut = HistoryViewModel.AccessibilityHandler(gather: gather)
        
        XCTAssertTrue(sut.accessibilityLabel.contains(drawText))
    }
    
    func testAccessibilityLabel_whenTeamAWon_containsTeamAText() {
        let gather = Gather.demoGathers[1]
        let sut = HistoryViewModel.AccessibilityHandler(gather: gather)
        
        XCTAssertTrue(sut.accessibilityLabel.contains(winnerTeamAText))
    }
    
    func testAccessibilityLabel_whenTeamBWon_containsTeamBText() {
        let gather = Gather.demoGathers[2]
        let sut = HistoryViewModel.AccessibilityHandler(gather: gather)
        
        XCTAssertTrue(sut.accessibilityLabel.contains(winnerTeamBText))
    }
    
    func testAccessibilityLabel_whenScoreIsInvalid_doesNotContainScoreDescription() {
        let gather = Gather(
            score: "1@1",
            teamAPlayers: .demoPlayers,
            teamBPlayers: .demoPlayers
        )
        let sut = HistoryViewModel.AccessibilityHandler(gather: gather)
        
        let accessibilityLabel = sut.accessibilityLabel
        
        XCTAssertFalse(accessibilityLabel.contains(drawText))
        XCTAssertFalse(accessibilityLabel.contains(winnerTeamAText))
        XCTAssertFalse(accessibilityLabel.contains(winnerTeamBText))
    }
    
}
