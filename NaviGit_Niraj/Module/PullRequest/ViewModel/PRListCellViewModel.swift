//
//  PRListCellViewModel.swift
//  NaviGit_Niraj
//
//  Created by Niraj Jha on 09/10/22.
//

import Foundation

enum PRListCellRowType {
    case prDetails
}

protocol PRListCellViewModelProtocol {
    var rowType: PRListCellRowType { get }
}

struct PRListCellViewModel: PRListCellViewModelProtocol {
    let rowType: PRListCellRowType = .prDetails
    let title: String
    let userName: String?
    let createdDate: String?
    let closedDate: String?
    let avtarUrl: URL?

    init(prInfo: PullRequest) {
        self.title = prInfo.title
        self.userName = prInfo.user?.login
        self.createdDate = prInfo.createdAt?.date
        self.closedDate = prInfo.closedAt?.date

        if let urlStr = prInfo.user?.avatarURL,
           let avtarUrl = URL(string: urlStr) {
            self.avtarUrl = avtarUrl
        } else {
            self.avtarUrl = nil
        }
    }
}
