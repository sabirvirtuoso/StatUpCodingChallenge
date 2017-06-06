//
//  UIApplication.swift
//  StatUpCodingChallenge
//
//  Created by Syed Sabir Salman on 6/6/17.
//  Copyright © 2017 Syed Sabir Salman. All rights reserved.
//

import UIKit

extension UIApplication {
    
    /**
     Finds the top-most view controller that is currently being displayed
     http://stackoverflow.com/questions/11637709/get-the-current-displaying-uiviewcontroller-on-the-screen-in-appdelegate-m#answer-28699092
     */
    func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController)
        -> UIViewController? {
            
            if let nav = base as? UINavigationController {
                return topViewController(nav.visibleViewController)
            }
            
            if let tab = base as? UITabBarController {
                let moreNavigationController = tab.moreNavigationController
                
                if let top = moreNavigationController.topViewController, top.view.window != nil {
                    return topViewController(top)
                } else if let selected = tab.selectedViewController {
                    return topViewController(selected)
                }
            }
            
            if let presented = base?.presentedViewController {
                return topViewController(presented)
            }
            
            return base
    }
}
