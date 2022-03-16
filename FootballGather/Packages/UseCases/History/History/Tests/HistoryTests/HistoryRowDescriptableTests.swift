//
//  HistoryRowDescriptableTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 14.01.2022.
//

import XCTest
import CoreModels
import FoundationMocks
@testable import History

final class HistoryRowDescriptableTests: XCTestCase {
    
    override func tearDown() {
        Mocks.storage.clear()
        super.tearDown()
    }
    
    func testTitle_teamA_isTeamName() {
        XCTAssertEqual(makeTeamARowDescription().title, Team.teamA.name)
    }
    
    func testTitle_teamB_isTeamName() {
        XCTAssertEqual(makeTeamBRowDescription().title, Team.teamB.name)
    }
    
    func testPlayersDescription_teamA_isViewModelPlayerDescription() {
        let viewModel = HistoryViewModel(storage: Mocks.storage)
        let sut = makeTeamARowDescription(viewModel: viewModel)
        
        Gather.demoGathers.forEach { gather in
            let expectedDescription = viewModel.teamAPlayersDescription(for: gather)
            XCTAssertEqual(sut.playersDescription(for: gather), expectedDescription)
        }
    }
    
    func testPlayersDescription_teamB_isViewModelPlayerDescription() {
        let viewModel = HistoryViewModel(storage: Mocks.storage)
        let sut = makeTeamBRowDescription(viewModel: viewModel)
        
        Gather.demoGathers.forEach { gather in
            let expectedDescription = viewModel.teamBPlayersDescription(for: gather)
            XCTAssertEqual(sut.playersDescription(for: gather), expectedDescription)
        }
    }
    
    // MARK: - Helpers
    
    private func makeTeamARowDescription(
        with gathers: [Gather] = .demoGathers,
        viewModel: HistoryViewModel = .init(storage: Mocks.storage)
    ) -> TeamARowDescription {
        addGathersToStorage(gathers)
        return TeamARowDescription(viewModel: viewModel)
    }
    
    private func makeTeamBRowDescription(
        with gathers: [Gather] = .demoGathers,
        viewModel: HistoryViewModel = .init(storage: Mocks.storage)
    ) -> TeamBRowDescription {
        addGathersToStorage()
        return TeamBRowDescription(viewModel: viewModel)
    }
    
    private func addGathersToStorage(_ gathers: [Gather] = .demoGathers) {
        Gather.demoGathers.forEach { Mocks.storage.addGather($0) }
    }
    
}
