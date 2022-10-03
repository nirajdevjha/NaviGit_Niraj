//
//  PRListViewModel.swift
//  NaviGit_Niraj
//
//  Created by Niraj Jha on 29/09/22.
//

import Foundation

protocol PRListViewModelProtocol {
    func getPRList()
}

protocol PRListViewModelDelegate: AnyObject {

}

final class PRListViewModel: PRListViewModelProtocol {
    private let service: PRService

    init(service: PRService) {
        self.service = service
    }

    func getPRList() {
        let request = PullRequestAPIData(category: .closed, owner: "ReactiveX", repo: "RxSwift")
        service.fetchPullRequests(requestData: request) { [weak self] result in
            guard let self = self else { return }
        }
    }
}
