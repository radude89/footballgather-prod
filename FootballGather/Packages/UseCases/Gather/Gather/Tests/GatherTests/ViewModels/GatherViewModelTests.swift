//
//  GatherViewModelTests.swift
//  FootballGatherTests
//
//  Created by Radu Dan on 29.11.2021.
//

import XCTest
import CoreModels
import FoundationTools
import FoundationMocks
@testable import Gather

final class GatherViewModelTests: XCTestCase {
    
    func testInit() {
        let sut = GatherViewModel(
            playersTeams: [.teamA: .demoPlayers, .teamB: .demoPlayers]
        )

        XCTAssertEqual(sut.playersTeams[.teamA], .demoPlayers)
        XCTAssertEqual(sut.playersTeams[.teamB], .demoPlayers)
        XCTAssertNil(sut.playersTeams[.bench])
    }

    func testFormattedTime() {
        let sut = GatherViewModel(playersTeams: [:])
        let time = sut.formattedTime(from: .init())
        let expectedTime = GatherTimeFormatter(
            seconds: GatherDefaultTime.value()
        )
            .formattedTime
            .components(separatedBy: ":")

        XCTAssertEqual(time.minutes, expectedTime[0])
        XCTAssertEqual(time.seconds, expectedTime[1])
    }

    func testStoreGather() {
        let storage = FoundationMocks.Mocks.GatherStorageHandler()
        let sut = GatherViewModel(playersTeams: [:])
        
        sut.storeGather(score: "1-1", storage: storage)
        
        XCTAssertTrue(storage.addGatherCalled)
    }
    
}
