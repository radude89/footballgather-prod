//
//  HelloWorldTests.swift
//  Tests iOS
//
//  Created by Radu Dan on 25.03.2021.
//

import XCTest

final class HelloWorldTests: XCTestCase {

    func testHelloWorld() {
        let test = "My First Test"
        XCTAssertTrue(true)
        XCTAssertEqual(test, "My First Test")
    }
    
    func testHelloWorld2() {
        let test = "My Second Test"
        XCTAssertTrue(true)
        XCTAssertEqual(test, "My Second Test")
    }
    
}
