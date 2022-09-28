//
//  APIEndpoint.swift
//  NaviGit_Niraj
//
//  Created by Niraj Kumar Jha on 17/09/22.
//

import Foundation

enum APIEndPoint {
    case pullRequests

    var scheme: String {
        switch self {
        case .pullRequests:
            return Constants.Api.scheme
        }
    }

    var host: String {
        switch self {
        case .pullRequests:
            return Constants.Api.host
        }
    }

    var path: String {
        switch self {
        case .pullRequests:
            return "/repos"
        }
    }

    var parameters: [URLQueryItem] {
        switch self {
        case .pullRequests:
            return []
        }
    }
}
