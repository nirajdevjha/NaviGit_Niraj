//
//  PRRequestTests.swift
//  NaviGit_NirajTests
//
//  Created by Niraj Jha on 10/10/22.
//

import XCTest
@testable import NaviGit_Niraj

final class PRRequestTests: XCTestCase {
    var request: PRRequest!
    let testRequestData = PullRequestAPIData(category: .closed, owner: "apple", repo: "swift", perPage: 20, page: 1)

    override func setUpWithError() throws {
        request = PRRequest(requestData: testRequestData)
    }

    override func tearDownWithError() throws {
        request = nil
    }

    func testPRRequestAPIScheme() {
        XCTAssert(request.scheme == APIEndPoint.pullRequests.scheme, "Pull Requests API scheme does not match")
    }

    func testPRRequestAPIEndPoint() {
        XCTAssert(request.endPoint == "\(APIEndPoint.pullRequests.path)/apple/swift/issues", "Pull Requests API endpoint does not match")
    }

    func testPRRequestAPIParameters() {
        var params = APIEndPoint.pullRequests.parameters
        params.append(URLQueryItem(name: "state", value: "\(testRequestData.category.rawValue)"))
        params.append(URLQueryItem(name: "per_page", value: "\(testRequestData.perPage)"))
        params.append(URLQueryItem(name: "page", value: "\(testRequestData.page)"))
        XCTAssert(request.parameters == params, "Pull Requests API parameters does not match")
    }

    func testPRRequestAPIRequestMethod() {
        XCTAssert(request.requestMethod == .get, "Pull Requests API requires request method to be `get`")
    }

    func testPRRequestAPIEncoding() {
        XCTAssert(request.encoding == .url, "Pull Requests API requires encoding to be `url`")
    }

    func testPRRequestAPIBody() {
        if let body = request.body {
            XCTAssert(body.isEmpty, "Pull Requests API deos not require http body")
        } else {
            XCTAssert(request.body == nil, "Pull Requests API deos not require http body")
        }
    }
}
