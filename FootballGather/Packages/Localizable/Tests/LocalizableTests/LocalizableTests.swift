import XCTest
@testable import Localizable

final class LocalizableTests: XCTestCase {
    
    func testLocalizedTexts() {
        let localizedTextDictionary = [
            "players": LocalizedText.players,
            "no.players": LocalizedText.noPlayers
        ]
        
        localizedTextDictionary.forEach { key, value in
            XCTAssertEqual(
                value,
                NSLocalizedString(key, bundle: Bundle.module, comment: ""),
                "Text at \"\(key)\", is not equal with localized text \"\(value)\"."
            )
        }
    }

}

extension LocalizableTests {
    static var allTests = [
        ("testLocalizedTexts", testLocalizedTexts),
    ]
}
