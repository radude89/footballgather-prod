//
//  FileStorage.swift
//  
//
//  Created by Radu Dan on 28.05.2021.
//

import XCTest
@testable import FoundationTools

final class FileStorageTests: XCTestCase {
    
    private var sut: FileStorage<String, [String]>!
    private var fileManager: FileManager!
    private let path = NSTemporaryDirectory() + "FileStorageTests"
    private let fileKey = "test-data.json"
    private let storedObjects = ["stored-value"]
    
    private var mockEncoder: Mocks.Encoder!
    private var storageCoder: StorageCoder!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        try makeSUT()
    }
    
    override func tearDownWithError() throws {
        try? fileManager.removeItem(atPath: path)
        mockEncoder = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func testStoreValue_storesData() {
        sut.store(storedObjects, at: fileKey)
        XCTAssertEqual(storedObjects, sut.load(forKey: fileKey))
    }
    
    func testStoreValue_whenCoderThrowsError_returns() {
        mockEncoder.error = Mocks.StorageError.generic
        sut.store(storedObjects, at: fileKey)
        XCTAssertNil(sut.load(forKey: fileKey))
    }
    
    func testDeleteObject() {
        sut.store(storedObjects, at: fileKey)
        sut.deleteObject(forKey: fileKey)
        XCTAssertNil(sut.load(forKey: fileKey))
    }
    
    func testClear() {
        sut.store(storedObjects, at: fileKey)
        sut.clear()
        XCTAssertNil(sut.load(forKey: fileKey))
    }
    
    func testClear_whenDirectoryIsMissing_returns() {
        try? fileManager.removeItem(atPath: path)
        sut.store(storedObjects, at: fileKey)

        sut.clear()

        XCTAssertNil(sut.load(forKey: fileKey))
    }
    
    func testDocumentsDirectoryURL() {
        XCTAssertEqual(
            FileManager.documentsDirectoryURL,
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        )
    }
    
    func testLoad_whenKeyIsNotString_isNil() {
        let sut = FileStorage<Key, String>(fileManager: .init())
        XCTAssertNil(sut.load(forKey: Key()))
    }
    
    func testDeleteObject_whenKeyIsNotString_isNil() {
        let sut = FileStorage<Key, String>(fileManager: .init())
        sut.deleteObject(forKey: Key())
        XCTAssertNil(sut.load(forKey: Key()))
    }
    
    func testClear_whenContentsOfDirectoryAreEmpty_isNil() throws {
        let url = URL(string: "20")!
        let sut = FileStorage<Key, String>(fileManager: .init(), documentsURL: url)
        
        sut.clear()
        
        XCTAssertNil(sut.load(forKey: Key()))
    }
    
    // MARK: - Helpers
    
    private struct Key: Hashable {}
    
    private func makeSUT() throws {
        fileManager = .init()
        mockEncoder = .init()
        
        storageCoder = StorageCoder(
            encoder: mockEncoder,
            decoder: Mocks.Decoder()
        )
        
        sut = try Mocks.makeFileStorage(
            fileManager,
            filePath: fileKey,
            storageCoder: storageCoder
        )
    }
    
}
