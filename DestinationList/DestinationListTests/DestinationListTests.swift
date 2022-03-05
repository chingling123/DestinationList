//
//  DestinationListTests.swift
//  DestinationListTests
//
//  Created by Erik Nascimento on 05/03/2022.
//

import XCTest
@testable import DestinationList

class DestinationListTests: XCTestCase {
    var data: Data?
    
    override func setUpWithError() throws {
        data = FileLoader.loadData()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadMockData() throws {
        XCTAssertNotNil(data)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
