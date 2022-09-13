//
//  ApplicationCoordinator.swift
//  NaviGit_Niraj
//
//  Created by Niraj Kumar Jha on 12/09/22.
//

import UIKit

final class ApplicationCoordinator: Coordinator {
    private let window: UIWindow
    private let rootViewController: UINavigationController
    private var prListCoordinator: PRListCoordinator?

    init(
        window: UIWindow,
        rootViewController: UINavigationController = UINavigationController()
    ) {
        self.window = window
        self.rootViewController = rootViewController

        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            appearance.backgroundColor = .white
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            rootViewController.navigationBar.tintColor = .white
            rootViewController.navigationBar.barTintColor = .black
            rootViewController.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.black
            ]
        }
        prListCoordinator = PRListCoordinator(presenter: rootViewController)
    }

    func start() {
        window.rootViewController = rootViewController
        prListCoordinator?.start()
    }
}
