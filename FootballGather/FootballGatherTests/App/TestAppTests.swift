//
//  TestAppTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 18.05.2021.
//

import XCTest
import SwiftUI
@testable import FootballGather

final class TestAppTests: XCTestCase {
    
    func testBody() {
        XCTAssertNotNil(TestApp().body as? WindowGroup<Text>)
    }
    
}
