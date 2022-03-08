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
    var vm: DestinationViewModel!
    var dataSource: DestinationDataSource!
    let tableView = UITableView()
    
    override func setUpWithError() throws {
        data = FileLoader.loadData()
        vm = DestinationViewModel()
        vm.fetchData()
        dataSource = vm.dataSource
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadMockData() throws {
        XCTAssertNotNil(data)
    }
    
    func testFetcherData() throws {
        XCTAssertNotNil(dataSource.destinations)
    }

    func testTableViewDataSourceIsKittenDataSource() {
        XCTAssertEqual(dataSource.destinations?.count, 14)
    }
    
    func testNumberOfRows() {
        let numberOfRows = dataSource.tableView(tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(numberOfRows, 14)
    }
}
