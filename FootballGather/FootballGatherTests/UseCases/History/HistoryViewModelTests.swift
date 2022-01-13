//
//  HistoryViewModelTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 13.01.2022.
//

import XCTest
import CoreModels
@testable import FootballGather

final class HistoryViewModelTests: XCTestCase {
    
    func testGathersList_isEmpty() {
        let sut = HistoryViewModel()
        XCTAssertTrue(sut.gathers.isEmpty)
    }
    
    func testGatherList_whenHasEntries_showsGatherDetails() {
        
    }
    
}

struct HistoryViewModel {
    let gathers: [Gather] = []
}
