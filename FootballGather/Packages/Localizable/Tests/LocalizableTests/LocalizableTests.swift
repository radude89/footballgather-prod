import XCTest
@testable import Localizable

final class LocalizableTests: XCTestCase {
    
    func testLocalizedTexts() {
        XCTAssertEqual(LocalizedText.hello, NSLocalizedString("hello", bundle: Bundle.module, comment: ""))
    }

}

extension LocalizableTests {
    static var allTests = [
        ("testLocalizedTexts", testLocalizedTexts),
    ]
}
