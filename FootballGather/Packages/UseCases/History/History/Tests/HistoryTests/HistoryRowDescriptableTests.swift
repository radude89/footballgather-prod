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
    
    private let gathers: [Gather] = .demoGathers
    
    @MainActor 
    func testPlayersDescription_teamA_isViewModelPlayerDescription() {
        let storage = Mocks.GatherStorageHandler(gathers: gathers)
        let viewModel = HistoryViewModel(storage: storage)
        let sut = TeamARowDescription(viewModel: viewModel)
        
        gathers.forEach { gather in
            let expectedDescription = viewModel.teamAPlayersDescription(for: gather)
            XCTAssertEqual(sut.playersDescription(for: gather), expectedDescription)
        }
    }
    
    @MainActor
    func testPlayersDescription_teamB_isViewModelPlayerDescription() {
        let storage = Mocks.GatherStorageHandler(gathers: gathers)
        let viewModel = HistoryViewModel(storage: storage)
        let sut = TeamBRowDescription(viewModel: viewModel)
        
        gathers.forEach { gather in
            let expectedDescription = viewModel.teamBPlayersDescription(for: gather)
            XCTAssertEqual(sut.playersDescription(for: gather), expectedDescription)
        }
    }
    
}
