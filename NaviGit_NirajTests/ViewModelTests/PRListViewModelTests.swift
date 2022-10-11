//
//  PRListViewModelTests.swift
//  NaviGit_NirajTests
//
//  Created by Niraj Jha on 11/10/22.
//

import XCTest
@testable import NaviGit_Niraj

final class PRListViewModelTests: XCTestCase {

    var sut: PRListViewModel!
    var mockDelegate: MockPRListViewModelDelegate!
    var mockService: MockPRService!

    override func setUpWithError() throws {
        mockDelegate = MockPRListViewModelDelegate()
        mockService = MockPRService(isError: false)
        sut = PRListViewModel(service: mockService)
        sut.delegate = mockDelegate
    }

    override func tearDownWithError() throws {
        mockDelegate = nil
        mockService = nil
        sut.delegate = nil
        sut = nil
    }

    func testGetPRListSuccessfully() {
        sut.getPRList()
        XCTAssertEqual(mockDelegate.isShowingLoader.timesCalled, 1)
        XCTAssertEqual(mockDelegate.isHidingLoader.timesCalled, 1)
        XCTAssertEqual(mockDelegate.isTableReloaded.timesCalled, 1)
    }

    func testGetPRListUnSuccessfully() {
        mockService.isError = true
        sut.getPRList()
        XCTAssertEqual(mockDelegate.isShowingLoader.timesCalled, 1)
        XCTAssertEqual(mockDelegate.isHidingLoader.timesCalled, 1)
        XCTAssertEqual(mockDelegate.isTableReloaded.timesCalled, 0)
    }

    func testNumberOfRowsInTable() {
        sut.getPRList()
        let numOfRows = sut.numberOfRows(in: 0)
        XCTAssertEqual(numOfRows, 2, "There are total 2 rows")
    }

    func testCellViewModelAtIndex() {
        sut.getPRList()

        if let cellVM = sut.getCellViewModel(at: 0) {
            XCTAssertEqual(cellVM.rowType, .prDetails)
            if let cellVM = cellVM as? PRListCellViewModel {
                XCTAssertEqual(cellVM.title, "Fix memory leak")
                XCTAssertEqual(cellVM.userName, "User001")
                XCTAssertEqual(cellVM.avtarUrl?.absoluteString, "https://avatars.com/User001")
                XCTAssertEqual(cellVM.createdDate, "Created: 10 Oct, 2022")
                XCTAssertEqual(cellVM.closedDate, "Closed: 10 Oct, 2022")
            } else {
                XCTFail("cellVM is not of type PRListCellViewModel")
            }

        } else {
            XCTFail("Unable to get cell view model at index")
        }

    }

    func testIsLoadingCellIndexPathWhenThere() {
        sut.getPRList()
        let testIndexPath = IndexPath(row: 0, section: 0)
        let isLoadingCell = sut.isLoadingCellIndexPath(testIndexPath)
        XCTAssertFalse(isLoadingCell, "Its not the loading cell as current page is equal to 1")
    }

    func testIsLoadingCellIndexPathWhenNotThere() {
        sut.incrementCurrentPage()
        sut.getPRList()
        let testIndexPath = IndexPath(row: 1, section: 0)
        let isLoadingCell = sut.isLoadingCellIndexPath(testIndexPath)
        XCTAssertTrue(isLoadingCell, "It is loading cell as current page is greater than 1")
    }

    func testPageIncrement() {
        XCTAssertEqual(sut.currentPage, 1, "By default current page is 1")
        //increment page number
        sut.incrementCurrentPage()
        XCTAssertEqual(sut.currentPage, 2, "After incement current page is 2")
    }
}
