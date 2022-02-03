//
//  BayclockTests.swift
//  BayclockTests
//
//  Created by Sean Kuwamoto on 11/25/21.
//

import XCTest
@testable import Bayclock

class BayclockTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCompareDates() throws {
        // The date should be considered the same, even though one has zeros and the other doesn't.
        XCTAssert(compareDates(date1: "2001/05/03", date2: "2001/5/3") == 0)

        // If the date is less or greater, make sure it returns the right thing.
        XCTAssert(compareDates(date1: "2001/05/02", date2: "2001/5/3") < 0)
        XCTAssert(compareDates(date1: "2001/05/04", date2: "2001/5/3") > 0)

        // If the month is less or greater, make sure it returns the right thing.
        XCTAssert(compareDates(date1: "2001/04/03", date2: "2001/5/3") < 0)
        XCTAssert(compareDates(date1: "2001/06/03", date2: "2001/5/3") > 0)

        // If the month and day are both different, make sure the month takes precedence.
        XCTAssert(compareDates(date1: "2001/04/04", date2: "2001/5/3") < 0)
        XCTAssert(compareDates(date1: "2001/06/02", date2: "2001/5/3") > 0)


        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
