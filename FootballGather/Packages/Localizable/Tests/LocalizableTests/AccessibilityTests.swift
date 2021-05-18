import XCTest
import SwiftUI
@testable import Localizable

@available(iOS 14.0, *)
final class AccessibilityTests: XCTestCase {
    
    private let text = Text("Test")
    
    func testAccessibilityID() {
        AccessibilityID.allCases.forEach { accessibilityID in
            XCTAssertEqual(
                text.accessibilityID(accessibilityID).content,
                text.accessibilityIdentifier(accessibilityID.rawValue).content
            )
        }
    }
    
}

@available(iOS 14.0, *)
extension AccessibilityTests {
    static var allTests = [
        ("testAccessibilityID", testAccessibilityID),
    ]
}
