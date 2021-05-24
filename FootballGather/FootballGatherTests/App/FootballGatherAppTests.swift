//
//  FootballGatherAppTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 18.05.2021.
//

import XCTest
import SwiftUI
@testable import FootballGather

final class FootballGatherAppTests: XCTestCase {
    
    func testBody() {
        XCTAssertNotNil(FootballGatherApp().body as? WindowGroup<PlayersView>)
    }
    
}
