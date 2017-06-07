//
//  WebServiceResponseHandler.swift
//  StatUpCodingChallenge
//
//  Created by Syed Sabir Salman on 6/6/17.
//  Copyright © 2017 Syed Sabir Salman. All rights reserved.
//

import Foundation

public protocol WebServiceResponseHandler {
    
    /// Optional
    func success(_ httpStatusCode: Int, responseObject: Any?, jsonResponse: Any?)
    
    /// Optional
    /**
     * Return true to indicate some action has been taken, false to execute default action
     */
    func failure(_ httpStatusCode: Int, error: NSError?) -> Bool
    
    /// Optional
    func finally(_ httpStatusCode: Int)
    
}
