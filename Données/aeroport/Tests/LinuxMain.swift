import XCTest

import aeroportTests

var tests = [XCTestCaseEntry]()
tests += aeroportTests.allTests()
XCTMain(tests)