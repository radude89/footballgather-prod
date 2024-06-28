//
//  ConfirmPlayersViewModelTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 26.10.2021.
//

import XCTest
import CoreModels
@testable import TeamSelection

final class ConfirmPlayersViewModelTests: XCTestCase {
    
    private var sut: ConfirmPlayersViewModel!
    private let players = Player.demoPlayers
    
    @MainActor
    override func setUp() {
        super.setUp()
        sut = ConfirmPlayersViewModel(players: players)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    @MainActor
    func testTeams_equalsAllCases() {
        XCTAssertEqual(sut.teams, Team.allCases)
    }
    
    @MainActor
    func testNumberOfSections_equalsTeamsCount() {
        XCTAssertEqual(sut.numberOfSections, Team.allCases.count)
    }
    
    @MainActor
    func testNumberOfRows_whenSectionIsInvalid_isZero() {
        XCTAssertEqual(sut.numberOfRows(in: -1), 0)
        XCTAssertEqual(sut.numberOfRows(in: Int.max), 0)
        XCTAssertEqual(sut.numberOfRows(in: 999), 0)
        XCTAssertEqual(sut.numberOfRows(in: Team.allCases.count), 0)
        XCTAssertEqual(sut.numberOfRows(in: Team.allCases.count + 1), 0)
        XCTAssertEqual(sut.numberOfRows(in: -Int.max), 0)
    }
    
    @MainActor
    func testNumberOfRows_whenTeamIsAOrB_isZero() {
        XCTAssertEqual(numberOfRows(in: .teamA), 0)
        XCTAssertEqual(numberOfRows(in: .teamB), 0)
    }
    
    @MainActor
    func testNumberOfRows_whenTeamIsBench_isNumberOfDemoPlayers() {
        XCTAssertEqual(
            numberOfRows(in: .bench),
            players.count
        )
    }
    
    @MainActor
    func testTitleForHeaderInSection_isUppercased() {
        Team.allCases.forEach { team in
            let title = sut.titleForHeaderInSection(team.rawValue)
            XCTAssertEqual(title, team.name.uppercased())
        }
    }
    
    @MainActor
    func testRowTitle_equalsPlayersName() {
        players.enumerated().forEach { index, player in
            XCTAssertEqual(
                rowTitle(at: index, team: .bench),
                players[index].name
            )
        }
    }
    
    @MainActor
    func testRowTitle_whenSectionIsInvalid_isNil() {
        XCTAssertNil(rowTitle(section: -1))
        XCTAssertNil(rowTitle(section: Int.max))
        XCTAssertNil(rowTitle(section: 999))
        XCTAssertNil(rowTitle(section: Team.allCases.count))
        XCTAssertNil(rowTitle(section: Team.allCases.count + 1))
        XCTAssertNil(rowTitle(section: -Int.max))
    }
    
    @MainActor
    func testRowTitle_whenThereAreNotPlayers_isNil() {
        XCTAssertNil(rowTitle(at: 0, team: .teamA))
        XCTAssertNil(rowTitle(at: 0, team: .teamB))
    }
    
    @MainActor
    func testRowTitle_whenRowIndexIsInvalid_isNil() {
        XCTAssertNil(rowTitle(at: -1, team: .bench))
        XCTAssertNil(rowTitle(at: players.count, team: .bench))
        XCTAssertNil(rowTitle(at: players.count + 1, team: .bench))
        XCTAssertNil(rowTitle(at: Int.max, team: .bench))
        XCTAssertNil(rowTitle(at: -Int.max, team: .bench))
    }
    
    @MainActor
    func testMove() {
        move(from: .bench, to: .teamA)
        XCTAssertEqual(numberOfRows(in: .bench), players.count - 1)
        XCTAssertEqual(numberOfRows(in: .teamA), 1)
        XCTAssertFalse(sut.startGatherIsEnabled)
        
        move(from: .bench, to: .teamB)
        XCTAssertEqual(numberOfRows(in: .bench), players.count - 2)
        XCTAssertEqual(numberOfRows(in: .teamB), 1)
        XCTAssertEqual(numberOfRows(in: .teamA), 1)
        XCTAssertTrue(sut.startGatherIsEnabled)
        
        move(from: .teamB, to: .teamA)
        XCTAssertEqual(numberOfRows(in: .teamB), 0)
        XCTAssertEqual(numberOfRows(in: .teamA), 2)
        XCTAssertFalse(sut.startGatherIsEnabled)
        
        move(from: .teamA, to: .bench)
        move(from: .teamA, to: .bench)
        XCTAssertEqual(numberOfRows(in: .teamB), 0)
        XCTAssertEqual(numberOfRows(in: .teamA), 0)
        XCTAssertEqual(numberOfRows(in: .bench), players.count)
        XCTAssertFalse(sut.startGatherIsEnabled)
        
        move(from: .bench, to: .teamB)
        move(from: .bench, to: .teamB)
        move(from: .teamB, to: .teamA)
        move(from: .teamB, to: .bench)
        XCTAssertEqual(numberOfRows(in: .teamB), 0)
        XCTAssertEqual(numberOfRows(in: .teamA), 1)
        XCTAssertEqual(numberOfRows(in: .bench), players.count - 1)
        XCTAssertFalse(sut.startGatherIsEnabled)
    }
    
    @MainActor
    func testMove_whenSourceSectionIsInvalid_returns() {
        [Team.teamA, Team.teamB].forEach { team in
            move(from: -1, to: team.rawValue)
            XCTAssertEqual(numberOfRows(in: team), 0)
            XCTAssertFalse(sut.startGatherIsEnabled)
            
            move(from: -Int.max, to: team.rawValue)
            XCTAssertEqual(numberOfRows(in: team), 0)
            XCTAssertFalse(sut.startGatherIsEnabled)
            
            move(from: Int.max, to: team.rawValue)
            XCTAssertEqual(numberOfRows(in: team), 0)
            XCTAssertFalse(sut.startGatherIsEnabled)
            
            move(from: players.count, to: team.rawValue)
            XCTAssertEqual(numberOfRows(in: team), 0)
            XCTAssertFalse(sut.startGatherIsEnabled)
            
            move(from: players.count + 1, to: team.rawValue)
            XCTAssertEqual(numberOfRows(in: team), 0)
            XCTAssertFalse(sut.startGatherIsEnabled)
        }
    }
    
    @MainActor
    func testMove_whenDestinationSectionIsInvalid_returns() {
        move(from: Team.bench.rawValue, to: -1)
        XCTAssertEqual(numberOfRows(in: .teamA), 0)
        XCTAssertEqual(numberOfRows(in: .teamB), 0)
        XCTAssertFalse(sut.startGatherIsEnabled)
        
        move(from: Team.bench.rawValue, to: -Int.max)
        XCTAssertEqual(numberOfRows(in: .teamA), 0)
        XCTAssertEqual(numberOfRows(in: .teamB), 0)
        XCTAssertFalse(sut.startGatherIsEnabled)
        
        move(from: Team.bench.rawValue, to: Int.max)
        XCTAssertEqual(numberOfRows(in: .teamA), 0)
        XCTAssertEqual(numberOfRows(in: .teamB), 0)
        XCTAssertFalse(sut.startGatherIsEnabled)
        
        move(from: Team.bench.rawValue, to: players.count)
        XCTAssertEqual(numberOfRows(in: .teamA), 0)
        XCTAssertEqual(numberOfRows(in: .teamB), 0)
        XCTAssertFalse(sut.startGatherIsEnabled)
        
        move(from: Team.bench.rawValue, to: players.count + 1)
        XCTAssertEqual(numberOfRows(in: .teamA), 0)
        XCTAssertEqual(numberOfRows(in: .teamB), 0)
        XCTAssertFalse(sut.startGatherIsEnabled)
    }
    
    @MainActor
    func testMove_whenThereAreNotPlayers_returns() {
        move(from: .teamA, to: .bench)
        XCTAssertEqual(numberOfRows(in: .bench), players.count)
        XCTAssertFalse(sut.startGatherIsEnabled)
        
        move(from: .teamB, to: .bench)
        XCTAssertEqual(numberOfRows(in: .bench), players.count)
        XCTAssertFalse(sut.startGatherIsEnabled)
    }
    
    @MainActor
    func testMove_whenSourceRowIsInvalid_returns() {
        [Team.teamA, Team.teamB].forEach { team in
            move(from: .bench, sourceRowIndex: -1, to: team)
            XCTAssertEqual(numberOfRows(in: .bench), players.count)
            XCTAssertEqual(numberOfRows(in: team), 0)
            XCTAssertFalse(sut.startGatherIsEnabled)
            
            move(from: .bench, sourceRowIndex: -Int.max, to: team)
            XCTAssertEqual(numberOfRows(in: .bench), players.count)
            XCTAssertEqual(numberOfRows(in: team), 0)
            XCTAssertFalse(sut.startGatherIsEnabled)
            
            move(from: .bench, sourceRowIndex: Int.max, to: team)
            XCTAssertEqual(numberOfRows(in: .bench), players.count)
            XCTAssertEqual(numberOfRows(in: team), 0)
            XCTAssertFalse(sut.startGatherIsEnabled)
            
            move(from: .bench, sourceRowIndex: players.count, to: team)
            XCTAssertEqual(numberOfRows(in: .bench), players.count)
            XCTAssertEqual(numberOfRows(in: team), 0)
            XCTAssertFalse(sut.startGatherIsEnabled)
            
            move(from: .bench, sourceRowIndex: players.count + 1, to: team)
            XCTAssertEqual(numberOfRows(in: .bench), players.count)
            XCTAssertEqual(numberOfRows(in: team), 0)
            XCTAssertFalse(sut.startGatherIsEnabled)
        }
    }
    
    // MARK: - Helpers
    
    @MainActor
    private func numberOfRows(in team: Team) -> Int {
        sut.numberOfRows(in: team.rawValue)
    }
    
    @MainActor
    private func rowTitle(at row: Int = 0, section: Int) -> String? {
        sut.rowTitle(at: IndexPath(row: row, section: section))
    }
    
    @MainActor
    private func rowTitle(at row: Int, team: Team) -> String? {
        sut.rowTitle(
            at: IndexPath(
                row: row, section: team.rawValue
            )
        )
    }
    
    @MainActor
    private func move(
        from source: Team,
        sourceRowIndex: Int = 0,
        to destination: Team,
        destinationRowIndex: Int = 0
    ) {
        sut.move(
            from: .init(
                row: sourceRowIndex,
                section: source.rawValue
            ),
            to: .init(
                row: destinationRowIndex,
                section: destination.rawValue
            )
        )
    }
    
    @MainActor
    private func move(
        from sourceSection: Int,
        to destinationSection: Int
    ) {
        sut.move(
            from: .init(row: 0, section: sourceSection),
            to: .init(row: 0, section: destinationSection)
        )
    }
    
}
