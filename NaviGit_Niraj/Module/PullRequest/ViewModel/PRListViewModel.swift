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
    func isLoadingCellIndexPath(_ indexPath: IndexPath) -> Bool
    func incrementCurrentPage()
}

protocol PRListViewModelDelegate: AnyObject {
    func showLoader()
    func hideLoader()
    func reloadTable()
    func showError(title: String, message: String)
}

final class PRListViewModel: PRListViewModelProtocol {
    private let service: PRServiceProvider
    weak var delegate: PRListViewModelDelegate?

    private(set) var shouldShowLoadingCell: Bool = false
    private(set) var currentPage: Int = 1
    private var prCellViewModels: [PRListCellViewModelProtocol] = []

    init(service: PRServiceProvider) {
        self.service = service
    }

    private func preparePRCellViewModels(prList: [PullRequest]) {
        guard !prList.isEmpty else {
            prCellViewModels.removeAll()
            //ERROR
            return
        }

        for pr in prList {
            let prCellViewModel = PRListCellViewModel(prInfo: pr)
            prCellViewModels.append(prCellViewModel)
        }
        //This can be improved for infinite pagination
        shouldShowLoadingCell = currentPage < 15
    }

    func getPRList() {

        let request = PullRequestAPIData(category: .closed, owner: "apple", repo: "swift", page: currentPage)
        if currentPage == 1 {
            delegate?.showLoader()
        }
        service.fetchPullRequests(requestData: request) { [weak self] result in
            guard let self = self else { return }
            self.delegate?.hideLoader()
            switch result {
            case .success(let prList):
                self.preparePRCellViewModels(prList: prList)
                self.delegate?.reloadTable()
            case .failure(let error):
                self.delegate?.showError(title: "Error", message: error.genericMessgae)
                self.shouldShowLoadingCell = false
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

    func isLoadingCellIndexPath(_ indexPath: IndexPath) -> Bool {
        guard shouldShowLoadingCell else { return false }
        return indexPath.row == self.prCellViewModels.count - 1
    }

    func incrementCurrentPage() {
        self.currentPage += 1
    }
}
