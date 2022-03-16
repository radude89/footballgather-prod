//
//  MemoryStorageTests.swift
//  
//
//  Created by Radu Dan on 25.05.2021.
//

import XCTest
import FoundationMocks
@testable import FoundationTools

final class MemoryStorageTests: XCTestCase {
    
    private var sut: MemoryStorage<String, [String]>!
    private let storageKey = Mocks.storageKey
    private let objectsToStore = ["stored-value"]
    private let anotherObjectToStore = "stored-another-value"
    
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
        sut.store(objectsToStore, at: storageKey)
        XCTAssertEqual(sut.load(forKey: storageKey), objectsToStore)
    }
    
    func testLoad_whenValueIsNil_isNil() {
        XCTAssertNil(sut.load(forKey: storageKey))
    }
    
    func testSubscriptGetter_whenValueIsNotNil_returnsValue() {
        sut.store(objectsToStore, at: storageKey)
        XCTAssertEqual(sut[storageKey], objectsToStore)
    }
    
    func testSubscriptGetter_whenValueIsNil_isNil() {
        XCTAssertNil(sut[storageKey])
    }

    func testSubscriptGetter_whenKeyIsNotFound_isNil() {
        sut.store(objectsToStore, at: storageKey)
        XCTAssertNil(sut["@"])
    }
    
    func testSubscriptSetter() {
        sut[storageKey] = objectsToStore
        XCTAssertEqual(sut[storageKey], objectsToStore)
    }
    
    func testSubscriptSetter_whenValueIsNil_clearsValue() {
        sut[storageKey] = objectsToStore
        sut[storageKey] = nil
        
        XCTAssertNil(sut[storageKey])
    }
    
    func testUpdate() {
        sut.store(objectsToStore, at: storageKey)
        sut.update([anotherObjectToStore], at: storageKey)
        
        XCTAssertEqual(sut.load(forKey: storageKey), [anotherObjectToStore])
    }
    
    func testDelete() {
        sut.store(objectsToStore, at: storageKey)
        sut.deleteObject(forKey: storageKey)
        
        XCTAssertNil(sut.load(forKey: storageKey))
    }
    
    func testClear() {
        var objectsToStore = objectsToStore
        objectsToStore.append(anotherObjectToStore)
        sut.store(objectsToStore, at: storageKey)
        sut.clear()
        
        XCTAssertNil(sut.load(forKey: storageKey))
    }
 
}
