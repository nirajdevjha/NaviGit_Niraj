//
//  UIView+Extensions.swift
//  NaviGit_Niraj
//
//  Created by Niraj Jha on 02/10/22.
//

import UIKit

extension UIView {

    /// Creates a view of the callee type.
    /// Callee can be any subclass of UIView.
    /// - Parameter translatesAutoresizingMaskIntoConstraints: Flag to turn on or off the autoResize.

    func disableAutoResize() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }

    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }

    var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set(newRadius) {
            self.layer.cornerRadius = newRadius
            self.layer.masksToBounds = newRadius > 0
        }
    }
}

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }
}
