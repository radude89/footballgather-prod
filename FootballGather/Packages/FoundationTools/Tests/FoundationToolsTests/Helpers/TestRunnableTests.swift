//
//  TestRunnableTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 18.05.2021.
//

import XCTest
@testable import FoundationTools

final class TestRunnableTests: XCTestCase {
    
    func testIsRunningTests() {
        XCTAssertTrue(MockRunnable.isRunningTests)
    }
    
    private enum MockRunnable: TestRunnable {}
    
}
