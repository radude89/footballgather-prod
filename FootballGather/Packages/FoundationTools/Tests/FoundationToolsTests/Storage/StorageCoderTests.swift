//
//  StorageCoderTests.swift
//  
//
//  Created by Radu Dan on 25.05.2021.
//

import XCTest
@testable import FoundationTools

final class StorageCoderTests: XCTestCase {
    
    private var sut: StorageCoder!
    
    override func setUp() {
        super.setUp()
        sut = .init()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testEncode() {
        XCTAssertNoThrow(try sut.encode(Model(name: "test")))
    }
    
    func testDecode() {
        let encoded = try! sut.encode(Model(name: "test"))
        XCTAssertNoThrow(try sut.decode(Model.self, from: encoded))
    }
    
    private struct Model: Codable {
        let name: String
    }
    
}
