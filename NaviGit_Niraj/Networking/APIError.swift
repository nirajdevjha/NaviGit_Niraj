//
//  APIError.swift
//  NaviGit_Niraj
//
//  Created by Niraj Kumar Jha on 17/09/22.
//

import Foundation

enum APIError: Error {
    case noInternet
    case invalidUrl
    case decodingError
    case timedOut
    case emptyData
    case serverError(Error)
    case unknown

    var genericMessgae: String {
        switch self {
        case .noInternet:
            return "You seem to be offline"
        default:
            return "We are working on it. Be right back"
        }
    }
}

struct ErrorHandler {
    static func getAPIError(_ error: Error) -> APIError {
        if let error = error as? URLError,
           error.code  == URLError.Code.notConnectedToInternet {
            return APIError.noInternet
        } else {
            return APIError.serverError(error)
        }
    }
}
