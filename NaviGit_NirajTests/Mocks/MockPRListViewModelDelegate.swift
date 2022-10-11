//
//  MockPRListViewModelDelegate.swift
//  NaviGit_NirajTests
//
//  Created by Niraj Jha on 11/10/22.
//

@testable import NaviGit_Niraj

class MockPRListViewModelDelegate: PRListViewModelDelegate {

    var isShowingLoader = MockModel()
    func showLoader() {
        isShowingLoader.timesCalled += 1
    }

    var isHidingLoader = MockModel()
    func hideLoader() {
        isHidingLoader.timesCalled += 1
    }

    var isTableReloaded = MockModel()
    func reloadTable() {
        isTableReloaded.timesCalled += 1
    }

    var isErrorShown = MockModel()
    func showError(title: String, message: String) {
        isErrorShown.timesCalled += 1
        isErrorShown.params = (title, message)
    }
}
