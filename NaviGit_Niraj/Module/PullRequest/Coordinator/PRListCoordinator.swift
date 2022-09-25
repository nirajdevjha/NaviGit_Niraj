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
        let prListVC = PRListViewController()
        self.prListVC = prListVC
        presenter?.pushViewController(prListVC, animated: true)
    }
}