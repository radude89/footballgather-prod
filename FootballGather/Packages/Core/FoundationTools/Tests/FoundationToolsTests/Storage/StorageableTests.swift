//
//  StorageableTests.swift
//  
//
//  Created by Radu Dan on 25.05.2021.
//

import XCTest
@testable import FoundationTools

final class StorageableTests: XCTestCase {
    
    private var sut: Mocks.Store<String, [String]>!
    private let value = "stored-value"
    private let anotherValue = "stored-another-value"
    
    override func setUp() {
        super.setUp()
        sut = .init()
    }
    
    override func tearDown() {
        sut.clear()
        sut = nil
        super.tearDown()
    }
 
    func testStore() {
        let value = "stored-value"
        sut.store([value])
        
        XCTAssertEqual(sut.load(), [value])
    }
    
    func testLoad_whenValueIsNil_isNil() {
        XCTAssertNil(sut.load())
    }
    
    func testUpdate() {
        sut.store([value])
        sut.update([anotherValue])
        
        XCTAssertEqual(sut.load(), [anotherValue])
    }
    
    func testDelete() {
        sut.store([value])
        sut.deleteObject()
        
        XCTAssertNil(sut.load())
    }
    
    func testClear() {
        sut.store([value, anotherValue])
        sut.clear()
        
        XCTAssertNil(sut.load())
    }
    
}
