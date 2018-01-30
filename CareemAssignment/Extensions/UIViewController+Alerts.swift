//
//  UIViewController+Alerts.swift
//  CareemAssignment
//
//  Created by Muhammad Tayyab Akram on 24/01/2018.
//  Copyright © 2018 Muhammad Tayyab Akram. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    func showOKAlert(title: String?, message: String?) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: Constants.General.ok, style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        present(controller, animated: true, completion: nil)
    }

    func showNetworkError() {
        showOKAlert(title: nil, message: Constants.Alert.networkError)
    }
}
