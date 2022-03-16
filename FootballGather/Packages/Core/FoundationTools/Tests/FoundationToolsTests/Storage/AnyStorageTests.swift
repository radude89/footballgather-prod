//
//  AnyStorageTests.swift
//  
//
//  Created by Radu Dan on 25.05.2021.
//

import XCTest
import FoundationMocks
@testable import FoundationTools

final class AnyStorageTests: XCTestCase {
    
    private var sut: AnyStorage<String, [String]>!
    private let storageKey = Mocks.storageKey
    private let storedValue = "stored-value"
    
    override func setUp() {
        super.setUp()
        sut = .init(Mocks.Store<String, [String]>())
    }
    
    override func tearDown() {
        sut.clear()
        sut = nil
        super.tearDown()
    }
    
    func testStore() {
        sut.store([storedValue], at: storageKey)
        XCTAssertEqual(sut.load(forKey: storageKey), [storedValue])
    }
    
    func testLoad_whenValueIsNil_isNil() {
        XCTAssertNil(sut.load(forKey: storageKey))
    }
    
    func testDeleteObject() {
        sut.store([storedValue], at: storageKey)
        sut.deleteObject(forKey: storageKey)
        
        XCTAssertNil(sut.load(forKey: storageKey))
    }
    
    func testClear() {
        let anotherStoredValue = "another-value"
        sut.store([storedValue, anotherStoredValue], at: storageKey)
        
        sut.clear()
        
        XCTAssertNil(sut.load(forKey: storageKey))
    }
    
}

