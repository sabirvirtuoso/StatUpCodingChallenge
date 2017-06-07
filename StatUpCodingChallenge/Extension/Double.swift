//
//  Double.swift
//  StatUpCodingChallenge
//
//  Created by Syed Sabir Salman on 6/7/17.
//  Copyright © 2017 Syed Sabir Salman. All rights reserved.
//

import Foundation

extension Double {
    
    /**
     Executes a block of code after a delay (in seconds)
     http://stackoverflow.com/questions/24034544/dispatch-after-gcd-in-swift/24318861#24318861
     
     Usage:
     
     0.4.delay() {
     // Do something here
     }
     */
    func delay(_ closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(self * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }
}
