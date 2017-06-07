//
//  ViewUtils.swift
//  StatUpCodingChallenge
//
//  Created by Syed Sabir Salman on 6/6/17.
//  Copyright © 2017 Syed Sabir Salman. All rights reserved.
//

import UIKit

open class ViewUtils {
 
    open static func showAlert(_ alert: UIAlertController) {
        UIApplication.shared.topViewController()?.present(alert, animated: true, completion: nil)
    }

    open static func createErrorAlert(message: String) -> UIAlertController {
        return UIAlertController.alertDialog(message, title: "Error")
    }
}
