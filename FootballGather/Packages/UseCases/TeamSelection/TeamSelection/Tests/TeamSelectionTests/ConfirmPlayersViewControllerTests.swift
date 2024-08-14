//
//  ConfirmPlayersViewControllerTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 02.11.2021.
//

import XCTest
import CoreModels
import TeamSelectionAssets
@testable import TeamSelection

final class ConfirmPlayersViewControllerTests: XCTestCase {
    
    private var sut: ConfirmPlayersViewController!
    private let playersCount = Player.demoPlayers.count
    private var gatherCoordinator: MockGatherCoordinator!
    
    override func setUp() async throws {
        try await super.setUp()

        gatherCoordinator = MockGatherCoordinator()
        sut = await ConfirmPlayersViewController(
            players: .demoPlayers,
            gatherCoordinator: gatherCoordinator
        )
        await sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        gatherCoordinator = nil
        sut = nil
        
        super.tearDown()
    }
    
    @MainActor
    func testNumberOfSections_isTeamCount() {
        XCTAssertEqual(numberOfSections(), Team.allCases.count)
    }
    
    @MainActor
    func testNumberOfRows_initial() {
        XCTAssertEqual(numberOfRows(in: .bench), Player.demoPlayers.count)
        XCTAssertEqual(numberOfRows(in: .teamA), 0)
        XCTAssertEqual(numberOfRows(in: .teamB), 0)
    }
    
    @MainActor
    func testTitleForHeaderInSection_displaysTeamTitle() {
        Team.allCases.forEach { team in
            XCTAssertEqual(sectionTitle(for: team), team.name.uppercased())
        }
    }
    
    @MainActor
    func testCanMoveRows_isTrue() {
        XCTAssertTrue(sut.tableView(.init(), canMoveRowAt: .init()))
    }
    
    @MainActor
    func testMoveRowAt_fromBenchToTeamA() {
        movePlayer(from: .bench, to: .teamA)
        
        XCTAssertEqual(numberOfRows(in: .bench), 2)
        XCTAssertEqual(numberOfRows(in: .teamA), 1)
        XCTAssertFalse(startGatherButton.isEnabled)
        
        assertPlayerName(
            at: 0,
            team: .bench,
            is: Player.demoPlayers[1].name
        )
        assertPlayerName(
            at: 1,
            team: .bench,
            is: Player.demoPlayers.last!.name
        )
        assertPlayerName(
            at: 0,
            team: .teamA,
            is: Player.demoPlayers.first!.name
        )
    }
    
    @MainActor
    func testMoveRowAt_fromBenchToTeamB() {
        movePlayer(from: .bench, to: .teamB)
        
        XCTAssertEqual(numberOfRows(in: .bench), 2)
        XCTAssertEqual(numberOfRows(in: .teamB), 1)
        XCTAssertFalse(startGatherButton.isEnabled)
        
        assertPlayerName(
            at: 0,
            team: .bench,
            is: Player.demoPlayers[1].name
        )
        assertPlayerName(
            at: 1,
            team: .bench,
            is: Player.demoPlayers.last!.name
        )
        assertPlayerName(
            at: 0,
            team: .teamB,
            is: Player.demoPlayers.first!.name
        )
    }
    
    @MainActor
    func testMoveRowAt_fromTeamBToTeamA() {
        movePlayer(from: .bench, to: .teamB)
        movePlayer(from: .bench, to: .teamB)
        movePlayer(from: .teamB, to: .teamA)
        
        XCTAssertEqual(numberOfRows(in: .bench), 1)
        XCTAssertEqual(numberOfRows(in: .teamA), 1)
        XCTAssertEqual(numberOfRows(in: .teamB), 1)
        XCTAssertTrue(startGatherButton.isEnabled)
        
        assertPlayerName(
            at: 0,
            team: .bench,
            is: Player.demoPlayers.last!.name
        )
        assertPlayerName(
            at: 0,
            team: .teamA,
            is: Player.demoPlayers[1].name
        )
        assertPlayerName(
            at: 0,
            team: .teamB,
            is: Player.demoPlayers.first!.name
        )
    }
    
    @MainActor
    func testMoveRowAt_fromTeamAToTeamB() {
        movePlayer(from: .bench, to: .teamA)
        movePlayer(from: .bench, to: .teamA)
        movePlayer(from: .teamA, to: .teamB)
        
        XCTAssertEqual(numberOfRows(in: .bench), 1)
        XCTAssertEqual(numberOfRows(in: .teamA), 1)
        XCTAssertEqual(numberOfRows(in: .teamB), 1)
        XCTAssertTrue(startGatherButton.isEnabled)
        
        assertPlayerName(
            at: 0,
            team: .bench,
            is: Player.demoPlayers.last!.name
        )
        assertPlayerName(
            at: 0,
            team: .teamA,
            is: Player.demoPlayers.first!.name
        )
        assertPlayerName(
            at: 0,
            team: .teamB,
            is: Player.demoPlayers[1].name
        )
    }
    
    @MainActor
    func testMoveRowAt_sourceIndexOutOfBounds() {
        [Team.teamA, Team.teamB].forEach { team in
            movePlayer(from: .bench, to: team, sourceRow: playersCount + 1)
            XCTAssertEqual(numberOfRows(in: .bench), playersCount)
            XCTAssertEqual(numberOfRows(in: team), 0)
            
            movePlayer(from: .bench, to: team, sourceRow: -1)
            XCTAssertEqual(numberOfRows(in: .bench), playersCount)
            XCTAssertEqual(numberOfRows(in: team), 0)
        }
    }
    
    @MainActor
    func testMoveRowAt_destinationIndexOutOfBounds() {
        [Team.teamA, Team.teamB].forEach { team in
            movePlayer(from: .bench, to: team, destinationRow: -1)
            XCTAssertEqual(numberOfRows(in: .bench), playersCount)
            XCTAssertEqual(numberOfRows(in: team), 0)
        }
    }
    
    @MainActor
    func testCellForRowAt_displaysPlayersName() {
        Player.demoPlayers.enumerated().forEach { index, player in
            XCTAssertEqual(
                cellTitle(at: index, team: .bench),
                player.name
            )
        }
    }
    
    @MainActor
    func testEditingStyleForRowAt_isNone() {
        XCTAssertEqual(
            sut.tableView(.init(), editingStyleForRowAt: .init()),
            .none
        )
    }
    
    @MainActor
    func testShouldIndentWhileEditingRowAt_isFalse() {
        XCTAssertFalse(
            sut.tableView(.init(), shouldIndentWhileEditingRowAt: .init())
        )
    }
    
    @MainActor
    func testSetEditing() throws {
        let tableView = try XCTUnwrap(
            sut.view.subviews.first { $0 is UITableView } as? UITableView
        )
        
        XCTAssertFalse(tableView.isEditing)
        
        sut.setEditing(true, animated: false)
        XCTAssertTrue(tableView.isEditing)
        
        sut.setEditing(false, animated: false)
        XCTAssertFalse(tableView.isEditing)
    }
    
    // MARK: - Helpers
    
    @MainActor
    private var startGatherButton: UIButton {
        sut.view.subviews.first {
            $0.accessibilityIdentifier == AccessibilityID.startGatherButton.rawValue
        } as! UIButton
    }
    
    @MainActor
    private func numberOfSections(
        in tableView: UITableView = .init()
    ) -> Int {
        sut.numberOfSections(in: tableView)
    }
    
    @MainActor
    private func numberOfRows(in team: Team) -> Int {
        sut.tableView(
            .init(),
            numberOfRowsInSection: team.rawValue
        )
    }
    
    @MainActor
    private func sectionTitle(for team: Team) -> String? {
        sut.tableView(.init(), titleForHeaderInSection: team.rawValue)
    }
    
    @MainActor
    private func movePlayer(
        from sourceTeam: Team,
        to destinationTeam: Team,
        sourceRow: Int = 0,
        destinationRow: Int = 0
    ) {
        sut.tableView(
            .init(),
            moveRowAt: IndexPath(
                row: sourceRow,
                section: sourceTeam.rawValue
            ),
            to: IndexPath(
                row: destinationRow,
                section: destinationTeam.rawValue
            )
        )
    }
    
    @MainActor
    private func assertPlayerName(
        at index: Int,
        team: Team,
        is name: String,
        line: UInt = #line
    ) {
        XCTAssertEqual(
            cellTitle(at: index, team: team),
            name,
            line: line
        )
    }
    
    @MainActor
    private func cellTitle(at row: Int, team: Team) -> String? {
        let cell = sut.tableView(
            .init(),
            cellForRowAt: IndexPath(
                row: row,
                section: team.rawValue
            )
        )
        
        return (cell.contentConfiguration as? UIListContentConfiguration)?.text
    }
    
    private final class MockGatherCoordinator: GatherCoordinatable {
        @MainActor
        func startGather(from parent: UIViewController, playersTeams: [Team : [Player]], animated: Bool) {
        }
    }
    
}
