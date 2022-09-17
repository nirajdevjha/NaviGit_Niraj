//
//  NetworkingProtocols.swift
//  NaviGit_Niraj
//
//  Created by Niraj Kumar Jha on 17/09/22.
//

import Foundation

public enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
}

public enum Encoding: String {
    case url = "URL"
    case json = "JSON"
}

public enum ResponseType {
    case data
    case string
    case json
    case `default`
}

protocol NetworkRequestData {
    var scheme: String { get }
    var host: String { get }
    var requestMethod: RequestMethod { get }
    var endPoint: String { get }
    var parameters: [URLQueryItem] { get }
    var body: Data? { get }
    var encoding: Encoding { get }
}

protocol JSONDecodeProvider {
    func decode<T: Decodable>(data: Data) throws -> T
}
