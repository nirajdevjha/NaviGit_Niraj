//
//  PRListCoordinator.swift
//  NaviGit_Niraj
//
//  Created by Niraj Kumar Jha on 12/09/22.
//

import UIKit

final class PRListCoordinator: Coordinator {
    private weak var presenter: UINavigationController?
    private var prListVC: PRListViewController?

    init(presenter: UINavigationController) {
        self.presenter = presenter
    }

    func start() {
        let networkManager: NetworkManagerProtocol = NetworkManager()
        let prService: PRServiceProvider = PRService(networkManager: networkManager)
        let viewModel: PRListViewModelProtocol = PRListViewModel(service: prService)
        let prListVC = PRListViewController(viewModel: viewModel, delegate: self)
        self.prListVC = prListVC
        presenter?.pushViewController(prListVC, animated: true)
    }
}

extension PRListCoordinator: PRListViewControllerDelegate {
    func showError(title: String, message: String) {
        UIAlertController.showAlert(from: prListVC, title: title, message: message)
    }
}
