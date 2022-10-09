//
//  UIColor+Extensions.swift
//  NaviGit_Niraj
//
//  Created by Niraj Jha on 10/10/22.
//

import UIKit

extension UIColor {
    static func getRgb(_ red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: (red/255.0), green: (green/255.0), blue: (blue/255.0), alpha: alpha)
    }

    static let appColor: UIColor = UIColor.getRgb(74, green: 154, blue: 228, alpha: 1.0)
    static let darkGrayTxtColor: UIColor = UIColor.getRgb(36, green: 36, blue: 36, alpha: 1.0)
    static let mediumGrayTxtColor: UIColor = UIColor.getRgb(80, green: 80, blue: 80, alpha: 1.0)

}
