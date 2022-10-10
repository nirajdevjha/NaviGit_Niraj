//
//  UIAlertController+Extensions.swift
//  NaviGit_Niraj
//
//  Created by Niraj Jha on 10/10/22.
//

import UIKit

extension UIAlertController {
    class func showAlert(
        from viewController: UIViewController?,
        title: String?,
        message: String?
    ) {

        guard let viewController = viewController else { return }

        let okAction = UIAlertAction(
            title: "Ok",
            style: .cancel)

        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)

        alertController.addAction(okAction)

        viewController.present(alertController, animated: true)
    }
}
