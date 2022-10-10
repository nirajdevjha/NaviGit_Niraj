//
//  PRServiceTests.swift
//  NaviGit_NirajTests
//
//  Created by Niraj Jha on 11/10/22.
//

import XCTest
@testable import NaviGit_Niraj

final class PRServiceTests: XCTestCase {

    let testRequestData = PullRequestAPIData(category: .closed, owner: "apple", repo: "swift", page: 1)

    func testPRRequestsServiceSuccessWithValidJSON() {
        let networkManager: NetworkManagerProtocol = NetworkManagerMock(
            mockFileName: "prValidResponse"
        )
        let expectation = self.expectation(description: "pr-list-service-valid-response")
        let service = PRService(networkManager: networkManager)

        service.fetchPullRequests(requestData: testRequestData) { result in
            switch result {
            case .success(let response):
                expectation.fulfill()
                XCTAssertNotNil(response, "pr list response should not be nil")
            case .failure:
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 2, handler: nil)

    }

    func testPRRequestsServiceSuccessWithInvalidJSON() {
        let networkManager: NetworkManagerProtocol = NetworkManagerMock(
            mockFileName: "prInValidResponse"
        )
        let expectation = self.expectation(description: "pr-list-service-invalid-response")
        let service = PRService(networkManager: networkManager)

        service.fetchPullRequests(requestData: testRequestData) { result in
            switch result {
            case .success:
                expectation.fulfill()
                XCTFail("pr list Api cannot succeed with invalid json")
            case .failure(let error):
                expectation.fulfill()
                XCTAssertTrue(error.genericMessgae == "We are working on it. Be right back")
            }
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
}
