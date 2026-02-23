//
//  GatherCoordinatorTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 09.02.2022.
//

import XCTest
import SwiftUI
import CoreModels
@testable import Home

@MainActor
final class GatherCoordinatorTests: XCTestCase {

    func testStartGather_setsPlayersTeams() {
        var playersTeams: [Team: [Player]]? = nil
        let binding = Binding(get: { playersTeams }, set: { playersTeams = $0 })
        let sut = GatherCoordinator(gatherPlayersTeams: binding)
        let expectedTeams: [Team: [Player]] = [.teamA: [Player.demoPlayers[0]]]

        sut.startGather(playersTeams: expectedTeams)

        XCTAssertEqual(playersTeams, expectedTeams)
    }

    func testStartGather_whenPlayersTeamsAreEmpty_setsEmptyDictionary() {
        var playersTeams: [Team: [Player]]? = nil
        let binding = Binding(get: { playersTeams }, set: { playersTeams = $0 })
        let sut = GatherCoordinator(gatherPlayersTeams: binding)

        sut.startGather(playersTeams: [:])

        XCTAssertEqual(playersTeams, [:])
    }

}
