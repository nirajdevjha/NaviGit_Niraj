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

    override func setUpWithError() throws {
        sut = PRListViewModel(service: <#T##PRServiceProvider#>)
    }

    override func tearDownWithError() throws {
        sut = nil
    }
}
