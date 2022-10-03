//
//  PRListViewController.swift
//  NaviGit_Niraj
//
//  Created by Niraj Kumar Jha on 12/09/22.
//

import UIKit

class PRListViewController: UIViewController {
    private let repoHeaderLabel: UILabel = {
        let label = UILabel().disableAutoResize()
        label.textAlignment = .center
        label.textColor = .darkGray
        return label
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView().disableAutoResize()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.separatorStyle = .none
        return tableView
    }()

    private let loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView().disableAutoResize()
        return loader
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }

    private func setupViews() {
        view.addSubviews(
            repoHeaderLabel,
            tableView,
            loader
        )
        NSLayoutConstraint.activate([
            repoHeaderLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            repoHeaderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            repoHeaderLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            tableView.topAnchor.constraint(equalTo: repoHeaderLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension PRListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
