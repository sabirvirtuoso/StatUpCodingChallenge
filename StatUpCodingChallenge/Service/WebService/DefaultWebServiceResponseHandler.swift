//
//  DefaultWebServiceResponseHandler.swift
//  StatUpCodingChallenge
//
//  Created by Syed Sabir Salman on 6/6/17.
//  Copyright © 2017 Syed Sabir Salman. All rights reserved.
//

import MBProgressHUD

open class DefaultWebServiceResponseHandler: WebServiceResponseHandler {
    
    fileprivate let successFunction: (_ httpStatusCode: Int, _ responseObject: Any?, _ jsonResponse: Any?) -> ()
    fileprivate let failureFunction: (_ httpStatusCode: Int, _ error: NSError?) -> Bool
    fileprivate let finallyFunction: (_ httpStatusCode: Int) -> ()
    
    weak var view: UIView?
    
    init(
        success: @escaping (_ httpStatusCode: Int, _ responseObject: Any?, _ jsonResponse: Any?) -> () = {
            httpStatusCode, responseObject, jsonResponse in
        },
        failure: @escaping (_ httpStatusCode: Int, _ error: NSError?) -> Bool = {
            httpStatusCode, error in
        
            return false
        },
        finally: @escaping (_ httpStatusCode: Int) -> () = {
            httpStatusCode in
        },
        view: UIView? = nil) {
        
        successFunction = success
        failureFunction = failure
        finallyFunction = finally
        self.view = view
    }
    
    open func success(_ httpStatusCode: Int, responseObject: Any?, jsonResponse: Any?) {
        successFunction(httpStatusCode, responseObject, jsonResponse)
    }
    
    open func failure(_ httpStatusCode: Int, error: NSError?) -> Bool {
        return failureFunction(httpStatusCode, error)
    }
    
    open func finally(_ httpStatusCode: Int) {
        if ((httpStatusCode == 0 || httpStatusCode >= 300) && view != nil) {
            MBProgressHUD.hide(for: view!, animated: true)
        }
        
        finallyFunction(httpStatusCode)
    }
}
