//
//  GatherDefaultTimeTests.swift
//  
//
//  Created by Radu Dan on 13.12.2021.
//

import XCTest
@testable import FoundationTools

final class GatherDefaultTimeTests: XCTestCase {
    
    func testDefaultTime_equalsTenMinutes() {
        let expectedTimeInSeconds = 10 * 60
        let sut = GatherDefaultTime.inSeconds
        
        XCTAssertEqual(sut, expectedTimeInSeconds)
    }
    
}
