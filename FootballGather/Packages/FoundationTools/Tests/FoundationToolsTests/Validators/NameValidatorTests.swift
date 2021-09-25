//
//  NameValidatorTests.swift
//  
//
//  Created by Radu Dan on 25.09.2021.
//

import XCTest
@testable import FoundationTools

final class NameValidatorTests: XCTestCase {
    
    func testIsValid_whenMeetsValidation_isTrue() {
        XCTAssertTrue(
            NameValidator(name: "John").isValid
        )
        XCTAssertTrue(
            NameValidator(name: "🐢").isValid
        )
    }
    
    func testIsValid_whenNameIsEmpty_isFalse() {
        XCTAssertFalse(
            NameValidator(name: "").isValid
        )
    }
    
    func testIsValid_whenContainsOnlySpaces_isFalse() {
        (0...50).forEach { index in
            let name = String(repeating: " ", count: index)
            XCTAssertFalse(
                NameValidator(name: name).isValid
            )
        }
    }
    
    func testIsValid_whenStartsWithSpaces_isFalse() {
        XCTAssertFalse(
            NameValidator(name: " John").isValid
        )
        XCTAssertFalse(
            NameValidator(name: " John Smith").isValid
        )
        XCTAssertFalse(
            NameValidator(name: " 🥁").isValid
        )
    }
    
}
