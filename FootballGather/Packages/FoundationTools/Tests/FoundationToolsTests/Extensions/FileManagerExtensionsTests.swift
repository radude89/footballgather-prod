//
//  FileManagerExtensionsTests.swift
//
//
//  Created by Radu Dan on 30.08.2021.
//

import XCTest
@testable import FoundationTools

final class FileManagerExtensionsTests: XCTestCase {
    
    func testDocumentsDirectoryURL() {
        XCTAssertEqual(
            FileManager.documentsDirectoryURL,
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        )
    }
    
}
