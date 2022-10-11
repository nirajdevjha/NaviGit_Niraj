//
//  PRListCellViewModelTests.swift
//  NaviGit_NirajTests
//
//  Created by Niraj Jha on 11/10/22.
//

import XCTest
@testable import NaviGit_Niraj

final class PRListCellViewModelTests: XCTestCase {
    
    func testPRListCellViewModelInit() {
        let testPrRequest = PullRequest(title: "Fix memory leak",
                                        createdAt: "2022-10-10T15:19:19Z",
                                        closedAt: "2022-10-10T18:22:05Z",
                                        user: UserInfo(login: "User001",
                                                       avatarUrl: "https://avatars.com/User001")
                                        )
        let sut = PRListCellViewModel(prInfo: testPrRequest)

        XCTAssertEqual(sut.userName, "User001")
        XCTAssertEqual(sut.avtarUrl?.absoluteString, "https://avatars.com/User001")
        XCTAssertEqual(sut.title, "Fix memory leak")
        XCTAssertEqual(sut.createdDate, "Created: 10 Oct, 2022")
        XCTAssertEqual(sut.closedDate, "Closed: 10 Oct, 2022")
    }
}
