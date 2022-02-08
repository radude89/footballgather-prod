//
//  ConfirmPlayersViewControllerTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 02.11.2021.
//

import XCTest
import CoreModels
import Localizable
@testable import FootballGather

final class ConfirmPlayersViewControllerTests: XCTestCase {
    
    private var sut: ConfirmPlayersViewController!
    private let playersCount = Player.demoPlayers.count
    private var gatherCoordinator: MockGatherCoordinator!
    
    override func setUp() {
        super.setUp()
        
        gatherCoordinator = MockGatherCoordinator()
        sut = ConfirmPlayersViewController(players: .demoPlayers, gatherCoordinator: gatherCoordinator)
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        gatherCoordinator = nil
        sut = nil
        
        super.tearDown()
    }
    
    func testNumberOfSections_isTeamCount() {
        XCTAssertEqual(numberOfSections(), Team.allCases.count)
    }
    
    func testNumberOfRows_initial() {
        XCTAssertEqual(numberOfRows(in: .bench), Player.demoPlayers.count)
        XCTAssertEqual(numberOfRows(in: .teamA), 0)
        XCTAssertEqual(numberOfRows(in: .teamB), 0)
    }
    
    func testTitleForHeaderInSection_displaysTeamTitle() {
        Team.allCases.forEach { team in
            XCTAssertEqual(sectionTitle(for: team), team.name.uppercased())
        }
    }
    
    func testCanMoveRows_isTrue() {
        XCTAssertTrue(sut.tableView(.init(), canMoveRowAt: .init()))
    }
    
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
    
    func testMoveRowAt_destinationIndexOutOfBounds() {
        [Team.teamA, Team.teamB].forEach { team in
            movePlayer(from: .bench, to: team, destinationRow: -1)
            XCTAssertEqual(numberOfRows(in: .bench), playersCount)
            XCTAssertEqual(numberOfRows(in: team), 0)
        }
    }
    
    func testCellForRowAt_displaysPlayersName() {
        Player.demoPlayers.enumerated().forEach { index, player in
            XCTAssertEqual(
                cellTitle(at: index, team: .bench),
                player.name
            )
        }
    }
    
    func testEditingStyleForRowAt_isNone() {
        XCTAssertEqual(
            sut.tableView(.init(), editingStyleForRowAt: .init()),
            .none
        )
    }
    
    func testShouldIndentWhileEditingRowAt_isFalse() {
        XCTAssertFalse(
            sut.tableView(.init(), shouldIndentWhileEditingRowAt: .init())
        )
    }
    
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
    
    func testStartGather() {
        let navController = MockNavController(rootViewController: sut)
        
        startGatherButton.sendActions(for: .touchUpInside)
        
        XCTAssertTrue(gatherCoordinator.gatherStarted)
        XCTAssertTrue(navController.viewControllerPushed)
        XCTAssertTrue(navController.pushedViewControllerIsConfirmPlayersViewController)
    }
    
    // MARK: - Helpers
    
    private var startGatherButton: UIButton {
        sut.view.subviews.first {
            $0.accessibilityIdentifier == AccessibilityID.startGatherButton.rawValue
        } as! UIButton
    }
    
    private func numberOfSections(
        in tableView: UITableView = .init()
    ) -> Int {
        sut.numberOfSections(in: tableView)
    }
    
    private func numberOfRows(in team: Team) -> Int {
        sut.tableView(
            .init(),
            numberOfRowsInSection: team.rawValue
        )
    }
    
    private func sectionTitle(for team: Team) -> String? {
        sut.tableView(.init(), titleForHeaderInSection: team.rawValue)
    }
    
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
    
    private final class MockNavController: UINavigationController {
        private(set) var viewControllerPushed = false
        private(set) var pushedViewControllerIsConfirmPlayersViewController = false
        
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            viewControllerPushed = true
            pushedViewControllerIsConfirmPlayersViewController = viewController is ConfirmPlayersViewController
        }
    }
    
    private final class MockGatherCoordinator: GatherCoordinatable {
        private(set) var gatherStarted = false
        
        func startGather(from parent: UIViewController, playersTeams: [Team : [Player]], animated: Bool) {
            gatherStarted = true
        }
    }
    
}
