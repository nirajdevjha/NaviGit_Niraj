//
//  PRRequest.swift
//  NaviGit_Niraj
//
//  Created by Niraj Jha on 26/09/22.
//

import Foundation

enum PRCategory: String {
    case closed = "closed"

    var title: String {
        switch self {
        case .closed: return "closed"
        }
    }
}

struct PullRequestAPIData {
    let category: PRCategory
    let owner: String
    let repo: String
    let perPage: Int
    let page: Int

    init(category: PRCategory,
         owner: String,
         repo: String,
         perPage: Int = 20,
         page: Int
    ) {
        self.category = category
        self.owner = owner
        self.repo = repo
        self.perPage = perPage
        self.page = page
    }
}

struct PRRequest: NetworkRequestData {
    private let requestData: PullRequestAPIData

    init(requestData: PullRequestAPIData) {
        self.requestData = requestData
    }

    var scheme: String {
        return APIEndPoint.pullRequests.scheme
    }

    var host: String {
        return APIEndPoint.pullRequests.host
    }

    var endPoint: String {
        return "\(APIEndPoint.pullRequests.path)/\(requestData.owner)/\(requestData.repo)/pulls"
    }

    var parameters: [URLQueryItem] {
        var parameters = APIEndPoint.pullRequests.parameters
        parameters.append(URLQueryItem(name: "state", value: "\(requestData.category.rawValue)"))
        parameters.append(URLQueryItem(name: "per_page", value: "\(requestData.perPage)"))
        parameters.append(URLQueryItem(name: "page", value: "\(requestData.page)"))
        return parameters
    }

    var requestMethod: RequestMethod {
        .get
    }

    private(set) var body: Data?

    var encoding: Encoding {
        .url
    }
}
