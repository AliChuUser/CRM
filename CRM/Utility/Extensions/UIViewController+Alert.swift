//
//  UIViewController+Alert.swift
//  CRM
//
//  Created by Aleksei Chudin on 29.12.2023.
//

import Foundation
import UIKit

extension UIViewController {

    public func showError(title: String?, message: String?, buttonText: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: buttonText, style: .default)
        ac.addAction(ok)
        present(ac, animated: true)
    }
}
