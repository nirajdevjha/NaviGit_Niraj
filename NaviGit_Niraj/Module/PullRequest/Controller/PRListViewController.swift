//
//  PRListViewController.swift
//  NaviGit_Niraj
//
//  Created by Niraj Kumar Jha on 12/09/22.
//

import UIKit

protocol PRListViewControllerDelegate: AnyObject {
    func showError(title: String, message: String)
}

class PRListViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView().disableAutoResize()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.register(PRTableViewCell.self, forCellReuseIdentifier: PRTableViewCell.reuseIdentifier)
        tableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: LoadingTableViewCell.reuseIdentifier)
        return tableView
    }()

    private let loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView().disableAutoResize()
        return loader
    }()

    private var viewModel: PRListViewModelProtocol
    private weak var delegate: PRListViewControllerDelegate?

    init(viewModel: PRListViewModelProtocol, delegate: PRListViewControllerDelegate?) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        view.backgroundColor = .white
        setupViews()
        viewModel.getPRList()
    }

    private func setupViews() {
        title = "Pull Requests"
        view.addSubviews(
            tableView,
            loader
        )
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

//MARK:- Table view Delegate and Datasource
extension PRListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard viewModel.isLoadingCellIndexPath(indexPath) else {
            return
        }

        viewModel.incrementCurrentPage()
        viewModel.getPRList()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if viewModel.isLoadingCellIndexPath(indexPath) {
            let cell: LoadingTableViewCell = tableView.dequeueReusableCell(withIdentifier: LoadingTableViewCell.reuseIdentifier, for: indexPath) as! LoadingTableViewCell
            cell.startLaoding(with: "Loading...")
            return cell
        }

        if let cellViewModel = viewModel.getCellViewModel(at: indexPath.row) {
            switch cellViewModel.rowType {
            case .prDetails:
                if let cellViewModel = cellViewModel as? PRListCellViewModel {
                    let cell = tableView.dequeueReusableCell(withIdentifier: PRTableViewCell.reuseIdentifier, for: indexPath) as! PRTableViewCell
                    cell.configure(from: cellViewModel)
                    return cell
                }
            }
        }
        return UITableViewCell()
    }
}

//MARK:- PRListViewModelDelegate
extension PRListViewController: PRListViewModelDelegate {
    func showLoader() {
        DispatchQueue.main.async {
            self.loader.startAnimating()
        }
    }

    func hideLoader() {
        DispatchQueue.main.async {
            self.loader.stopAnimating()
        }
    }

    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func showError(title: String, message: String) {
        DispatchQueue.main.async {
            self.delegate?.showError(title: title, message: message)
        }
    }
}
