//
//  FootballGatherTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 11.05.2021.
//

import XCTest
@testable import FootballGather

final class FootballGatherTests: XCTestCase {
    
    func testContentView() {
        let contentView = ContentView()
        XCTAssertNotNil(contentView.body)
    }

}
