//
//  String+Extensions.swift
//  NaviGit_Niraj
//
//  Created by Niraj Jha on 09/10/22.
//

import Foundation

extension String {
    var date: String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "d MMM, YYYY"
            return dateFormatter.string(from: date)
        }
        return nil
    }
}
