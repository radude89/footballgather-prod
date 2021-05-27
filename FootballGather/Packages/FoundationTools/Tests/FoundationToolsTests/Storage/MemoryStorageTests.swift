//
//  MemoryStorageTests.swift
//  
//
//  Created by Radu Dan on 25.05.2021.
//

import XCTest
@testable import FoundationTools

final class MemoryStorageTests: XCTestCase {
    
    private var sut: MemoryStorage<String, [String]>!
    private let storageKey = Mocks.storageKey
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
        sut.store([value], at: storageKey)
        XCTAssertEqual(sut.load(forKey: storageKey), [value])
    }
    
    func testLoad_whenValueIsNil_isNil() {
        XCTAssertNil(sut.load(forKey: storageKey))
    }
    
    func testSubscriptGetter_whenValueIsNotNil_returnsValue() {
        sut.store([value], at: storageKey)
        XCTAssertEqual(sut[storageKey], [value])
    }
    
    func testSubscriptGetter_whenValueIsNil_isNil() {
        XCTAssertNil(sut[storageKey])
    }

    func testSubscriptGetter_whenKeyIsNotFound_isNil() {
        sut.store([value], at: storageKey)
        XCTAssertNil(sut["@"])
    }
    
    func testSubscriptSetter() {
        sut[storageKey] = [value]
        XCTAssertEqual(sut[storageKey], [value])
    }
    
    func testSubscriptSetter_whenValueIsNil_clearsValue() {
        sut[storageKey] = [value]
        sut[storageKey] = nil
        
        XCTAssertNil(sut[storageKey])
    }
    
    func testUpdate() {
        sut.store([value], at: storageKey)
        sut.update([anotherValue], at: storageKey)
        
        XCTAssertEqual(sut.load(forKey: storageKey), [anotherValue])
    }
    
    func testDelete() {
        sut.store([value], at: storageKey)
        sut.deleteObject(forKey: storageKey)
        
        XCTAssertNil(sut.load(forKey: storageKey))
    }
    
    func testClear() {
        sut.store([value, anotherValue], at: storageKey)
        sut.clear()
        
        XCTAssertNil(sut.load(forKey: storageKey))
    }
 
}
