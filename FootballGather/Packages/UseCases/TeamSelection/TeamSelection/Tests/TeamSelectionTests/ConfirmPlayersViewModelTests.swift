//
//  ConfirmPlayersViewModelTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 26.10.2021.
//

import XCTest
import CoreModels
@testable import TeamSelection

@MainActor
final class ConfirmPlayersViewModelTests: XCTestCase {

    private var sut: ConfirmPlayersViewModel!
    private let players = Player.demoPlayers

    override func setUp() async throws {
        try await super.setUp()
        sut = ConfirmPlayersViewModel(players: players)
    }

    func testTeams_equalsAllCases() {
        XCTAssertEqual(sut.teams, Team.allCases)
    }

    func testMove() {
        move(from: .bench, to: .teamA)
        XCTAssertEqual(sut.playersTeams[.bench]?.count ?? 0, players.count - 1)
        XCTAssertEqual(sut.playersTeams[.teamA]?.count ?? 0, 1)
        XCTAssertFalse(sut.startGatherIsEnabled)

        move(from: .bench, to: .teamB)
        XCTAssertEqual(sut.playersTeams[.bench]?.count ?? 0, players.count - 2)
        XCTAssertEqual(sut.playersTeams[.teamB]?.count ?? 0, 1)
        XCTAssertEqual(sut.playersTeams[.teamA]?.count ?? 0, 1)
        XCTAssertTrue(sut.startGatherIsEnabled)

        move(from: .teamB, to: .teamA)
        XCTAssertEqual(sut.playersTeams[.teamB]?.count ?? 0, 0)
        XCTAssertEqual(sut.playersTeams[.teamA]?.count ?? 0, 2)
        XCTAssertFalse(sut.startGatherIsEnabled)

        move(from: .teamA, to: .bench)
        move(from: .teamA, to: .bench)
        XCTAssertEqual(sut.playersTeams[.teamB]?.count ?? 0, 0)
        XCTAssertEqual(sut.playersTeams[.teamA]?.count ?? 0, 0)
        XCTAssertEqual(sut.playersTeams[.bench]?.count ?? 0, players.count)
        XCTAssertFalse(sut.startGatherIsEnabled)

        move(from: .bench, to: .teamB)
        move(from: .bench, to: .teamB)
        move(from: .teamB, to: .teamA)
        move(from: .teamB, to: .bench)
        XCTAssertEqual(sut.playersTeams[.teamB]?.count ?? 0, 0)
        XCTAssertEqual(sut.playersTeams[.teamA]?.count ?? 0, 1)
        XCTAssertEqual(sut.playersTeams[.bench]?.count ?? 0, players.count - 1)
        XCTAssertFalse(sut.startGatherIsEnabled)
    }

    func testMove_whenThereAreNotPlayers_returns() {
        move(from: .teamA, to: .bench)
        XCTAssertEqual(sut.playersTeams[.bench]?.count ?? 0, players.count)
        XCTAssertFalse(sut.startGatherIsEnabled)

        move(from: .teamB, to: .bench)
        XCTAssertEqual(sut.playersTeams[.bench]?.count ?? 0, players.count)
        XCTAssertFalse(sut.startGatherIsEnabled)
    }

    // MARK: - Helpers

    private func move(from sourceTeam: Team, to destinationTeam: Team) {
        guard let player = (sut.playersTeams[sourceTeam] ?? []).first else { return }
        sut.move(player, to: destinationTeam)
    }

}
