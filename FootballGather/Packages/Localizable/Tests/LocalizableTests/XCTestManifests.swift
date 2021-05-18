import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(LocalizableTests.allTests),
        testCase(AccessibilityTests.allTests)
    ]
}
#endif
