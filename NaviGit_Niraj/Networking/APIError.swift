//
//  APIError.swift
//  NaviGit_Niraj
//
//  Created by Niraj Kumar Jha on 17/09/22.
//

import Foundation

enum APIError: Error {
    case invalidUrl
    case decodingError
    case timedOut
    case emptyData
    case unknown
}
