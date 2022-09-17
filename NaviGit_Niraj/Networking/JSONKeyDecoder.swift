//
//  JSONKeyDecoder.swift
//  NaviGit_Niraj
//
//  Created by Niraj Kumar Jha on 17/09/22.
//

import Foundation

struct JSONKeyDecoder: JSONDecodeProvider {

    func decode<T: Decodable>(data: Data) throws -> T {
        let jsonDecoder = JSONDecoder()
        return try jsonDecoder.decode(T.self, from: data)
    }
}
