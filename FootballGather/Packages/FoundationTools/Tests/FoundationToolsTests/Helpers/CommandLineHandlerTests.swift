//
//  CommandLineHandlerTests.swift
//  
//
//  Created by Radu Dan on 25.05.2021.
//

import XCTest
@testable import FoundationTools

final class CommandLineHandlerTests: XCTestCase {
    
    func testIsRunningUITests() {
        let sut = CommandLineHandler(
            commandLineArguments: [
                Command.runUITests.rawValue
            ]
        )
        XCTAssertTrue(sut.isRunningUITests)
    }
    
    func testIsRunningUITests_whenCommandLineArgsAreEmpty_isFalse() {
        let sut = CommandLineHandler(commandLineArguments: [])
        XCTAssertFalse(sut.isRunningUITests)
    }
    
    func testShouldPopulateStorage() {
        let sut = CommandLineHandler(
            commandLineArguments: [
                Command.populateStorage.rawValue
            ]
        )
        XCTAssertTrue(sut.shouldPopulateStorage)
    }
    
    func testShouldPopulateStorage_whenCommandLineArgsAreEmpty_isFalse() {
        let sut = CommandLineHandler(commandLineArguments: [])
        XCTAssertFalse(sut.shouldPopulateStorage)
    }
    
}
