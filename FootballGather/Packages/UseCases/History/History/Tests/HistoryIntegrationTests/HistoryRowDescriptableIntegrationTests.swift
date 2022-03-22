//
//  HistoryRowDescriptableIntegrationTests.swift
//  
//
//  Created by Radu Dan on 22.03.2022.
//

import XCTest
import CoreModels
import FoundationTools
import FoundationMocks
@testable import History

final class HistoryRowDescriptableIntegrationTests: XCTestCase {
    
    private let gathers = Gather.demoGathers
    private let storage = Mocks.storage
    
    override func setUp() {
        super.setUp()
        add(gathers, to: storage)
    }
    
    override func tearDown() {
        storage.clear()
        super.tearDown()
    }
    
    func testPlayersDescription_teamA_isViewModelPlayerDescription() {
        let viewModel = HistoryViewModel(storage: storage)
        let sut = TeamARowDescription(viewModel: viewModel)
        
        gathers.forEach { gather in
            let expectedDescription = viewModel.teamAPlayersDescription(for: gather)
            XCTAssertEqual(sut.playersDescription(for: gather), expectedDescription)
        }
    }
    
    func testPlayersDescription_teamB_isViewModelPlayerDescription() {
        let viewModel = HistoryViewModel(storage: storage)
        let sut = TeamBRowDescription(viewModel: viewModel)
        
        gathers.forEach { gather in
            let expectedDescription = viewModel.teamBPlayersDescription(for: gather)
            XCTAssertEqual(sut.playersDescription(for: gather), expectedDescription)
        }
    }
    
    // MARK: - Helpers
    
    private func add(
        _ gathers: [Gather] = .demoGathers,
        to storage: AppStorage
    ) {
        gathers.forEach { storage.addGather($0) }
    }
    
}
