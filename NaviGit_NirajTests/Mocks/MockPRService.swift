//
//  MockPRService.swift
//  NaviGit_NirajTests
//
//  Created by Niraj Jha on 11/10/22.
//


@testable import NaviGit_Niraj

class MockPRService: PRServiceProvider {

    private let isError: Bool
    private let testError = APIError.noInternet

    let testPullRequests: [PullRequest] = [
        PullRequest(title: "Fix memory leak",
                    createdAt: "2022-10-10T15:19:19Z",
                    closedAt: "2022-10-10T18:22:05Z",
                    user: UserInfo(login: "User001",
                                   avatarUrl: "https://avatars.com/123")
                   )
    ]

    init(isError: Bool) {
        self.isError = isError
    }

    func fetchPullRequests(requestData: PullRequestAPIData, completion: @escaping (Result<[PullRequest], APIError>) -> Void) {
        if isError {
            completion(.failure(testError))
        } else {
            completion(.success(testPullRequests))
        }
        return nil
    }

}
