//
//  TestAppTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 18.05.2021.
//

import XCTest
import SwiftUI
@testable import Football_Gather

final class TestAppTests: XCTestCase {

    @MainActor
    func testBody() {
        XCTAssertNotNil(TestApp().body as? WindowGroup<Text>)
    }
    
}
