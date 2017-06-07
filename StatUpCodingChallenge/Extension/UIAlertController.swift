//
//  UIAlertController.swift
//  StatUpCodingChallenge
//
//  Created by Syed Sabir Salman on 6/6/17.
//  Copyright © 2017 Syed Sabir Salman. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    static func alertDialog(_ message: String? = nil, title: String? = nil,
                            buttonTitle: String = "OK",
                            buttonActionHandler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: buttonActionHandler))
        
        return alert
    }
}
