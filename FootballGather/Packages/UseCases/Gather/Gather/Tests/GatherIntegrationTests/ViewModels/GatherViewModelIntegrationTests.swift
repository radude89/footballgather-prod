//
//  GatherViewModelIntegrationTests.swift
//  
//
//  Created by Radu Dan on 22.03.2022.
//

import XCTest
import FoundationMocks
@testable import Gather

final class GatherViewModelIntegrationTests: XCTestCase {
    
    private let storage = FoundationMocks.Mocks.storage
    
    override func tearDown() {
        storage.clear()
        super.tearDown()
    }
    
    @MainActor
    func testStoreGather() {
        let sut = GatherViewModel(playersTeams: [:])
        
        sut.storeGather(score: "1-1", storage: storage)
        
        let storedGathers = storage.gathers
        let gather = storedGathers[0]
        XCTAssertEqual(storedGathers.count, 1)
        XCTAssertEqual(gather.score, "1-1")
    }
    
}
