//
//  MBProgressHUD.swift
//  StatUpCodingChallenge
//
//  Created by Syed Sabir Salman on 6/7/17.
//  Copyright © 2017 Syed Sabir Salman. All rights reserved.
//

import MBProgressHUD

extension MBProgressHUD {
    
    static func indeterminateHUD(_ view: UIView!, labelText: String = "", animated: Bool = true) -> MBProgressHUD! {
        let progressHUD = MBProgressHUD.showAdded(to: view, animated: animated)
        progressHUD.label.text = labelText
        
        return progressHUD
    }
    
    static func successHUD(_ view: UIView!, replaceDisplayedHUD: Bool = true,
                           labelText: String = "Success",
                           hideAfterDelay delay: Double = 0.3) -> MBProgressHUD! {
        
        if (replaceDisplayedHUD) {
            MBProgressHUD.hide(for: view, animated: true)
        }
        
        let progressHUD = MBProgressHUD.showAdded(to: view, animated: true)
        
        progressHUD.mode = .customView
        progressHUD.customView = UIImageView(image: UIImage(named: "Checkmark-37x.png"))
        progressHUD.label.text = labelText
        progressHUD.hide(animated: true, afterDelay: delay)
        
        return progressHUD
    }
}
