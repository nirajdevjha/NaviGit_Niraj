//
//  Collection+Extensions.swift
//  NaviGit_Niraj
//
//  Created by Niraj Jha on 10/10/22.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
