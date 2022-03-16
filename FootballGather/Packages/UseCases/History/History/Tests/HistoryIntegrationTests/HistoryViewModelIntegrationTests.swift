//
//  HistoryViewModelIntegrationTests.swift
//  
//
//  Created by Radu Dan on 15.03.2022.
//

import XCTest
import FoundationTools
import CoreModels
import FoundationMocks
@testable import History

final class HistoryViewModelIntegrationTests: XCTestCase {
    
    override func tearDown() {
        Mocks.storage.clear()
        super.tearDown()
    }
        
    func testSortGathers() {
        let storage = makePopulatedStorage()
        let sut = HistoryViewModel(storage: storage)
        
        let gathers = sut.gathers
        
        XCTAssertTrue(gathers[0].completedAt > gathers[1].completedAt)
    }
    
    func testHasGathers_whenStorageIsNotEmpty_hasGathers() {
        let storage = makePopulatedStorage()
        let sut = HistoryViewModel(storage: storage)
        
        XCTAssertTrue(sut.hasGathers)
    }
    
    // MARK: - Helpers
    
    private func makePopulatedStorage() -> AppStorage {
        let storage = Mocks.storage
        let now = Date()
        let tomorrow = Calendar.current
            .date(byAdding: .day, value: 1, to: now)
        storage.addGather(makeGather(completedAt: now))
        storage.addGather(makeGather(completedAt: tomorrow!))
        return storage
    }
    
    private func makeGather(
        completedAt: Date,
        score: String = "0-0"
    ) -> Gather {
        Gather(
            completedAt: completedAt,
            score: score,
            teamAPlayers: [],
            teamBPlayers: []
        )
    }
    
}
