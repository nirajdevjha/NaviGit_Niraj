//
//  PRService.swift
//  NaviGit_Niraj
//
//  Created by Niraj Jha on 26/09/22.
//

import Foundation

protocol PRServiceProvider {
    func fetchPullRequests(requestData: PullRequestAPIData, completion: @escaping (Result<[PullRequest], APIError>) -> Void)
}

final class PRService {

    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
}

extension PRService: PRServiceProvider {
    func fetchPullRequests(requestData: PullRequestAPIData, completion: @escaping (Result<[PullRequest], APIError>) -> Void) {
        return networkManager.fetch(
            using: PRRequest(requestData: requestData),
            completion: { (result: Result<[PullRequest], APIError>) in
                completion(result)
            }
        )
    }
}
