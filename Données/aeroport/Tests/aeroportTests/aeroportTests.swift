import XCTest
@testable import aeroport

final class aeroportTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(aeroport().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
