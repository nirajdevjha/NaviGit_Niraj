//
//  LoadingTableViewCell.swift
//  NaviGit_Niraj
//
//  Created by Niraj Jha on 10/10/22.
//

import UIKit

final class LoadingTableViewCell: BaseTableViewCell {

    private lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView().disableAutoResize()
        loader.style = .medium
        loader.hidesWhenStopped = true
        return loader
    }()

    private lazy var loadingLabel: UILabel = {
        let label = UILabel().disableAutoResize()
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()

    static var reuseIdentifier: String {
        return String(describing: self)
    }

    override func initialSetup() {
        super.initialSetup()

        contentView.addSubview(loader)
        contentView.addSubview(loadingLabel)

        NSLayoutConstraint.activate([
            loader.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            loader.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            loadingLabel.topAnchor.constraint(equalTo: loader.bottomAnchor, constant: 8),
            loadingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            loadingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            loadingLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }

    func startLaoding(with loadingText: String) {
        loadingLabel.text = loadingText
        loader.startAnimating()
    }
}
