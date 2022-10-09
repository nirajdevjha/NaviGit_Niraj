//
//  PRListViewModel.swift
//  NaviGit_Niraj
//
//  Created by Niraj Jha on 29/09/22.
//

import Foundation

protocol PRListViewModelProtocol {
    var delegate: PRListViewModelDelegate? { get set }
    func getPRList()
    func numberOfRows(in section: Int) -> Int
    func getCellViewModel(at index: Int) -> PRListCellViewModelProtocol?
}

protocol PRListViewModelDelegate: AnyObject {
    func showLoader()
    func hideLoader()
    func reloadTable()
    func showError(message: String)
}

final class PRListViewModel: PRListViewModelProtocol {
    private let service: PRServiceProvider
    weak var delegate: PRListViewModelDelegate?

    private var prCellViewModels: [PRListCellViewModelProtocol] = []

    init(service: PRServiceProvider) {
        self.service = service
    }

    private func preparePRCellViewModels(prList: [PullRequest]) {
        prCellViewModels.removeAll()

        for pr in prList {
            let prCellViewModel = PRListCellViewModel(prInfo: pr)
            prCellViewModels.append(prCellViewModel)
        }
    }

    func getPRList() {
        self.delegate?.showLoader()
        let request = PullRequestAPIData(category: .closed, owner: "Apple", repo: "Swift")
        service.fetchPullRequests(requestData: request) { [weak self] result in
            guard let self = self else { return }
            self.delegate?.hideLoader()
            switch result {
            case .success(let prList):
                self.preparePRCellViewModels(prList: prList)
                self.delegate?.reloadTable()
            case .failure(let error):
                break
            }
        }
    }

    func numberOfRows(in section: Int) -> Int {
        let numOfRows = prCellViewModels.count
        return numOfRows
    }

    func getCellViewModel(at index: Int) -> PRListCellViewModelProtocol? {
        let cellViewModel = prCellViewModels[safe: index]
        return cellViewModel
    }
}
