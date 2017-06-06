//
//  WebServiceHelper.swift
//  StatUpCodingChallenge
//
//  Created by Syed Sabir Salman on 6/6/17.
//  Copyright © 2017 Syed Sabir Salman. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import CocoaLumberjack

open class WebServiceHelper {
    
    fileprivate static let userAgentHeaderName = "User-Agent"
    
    fileprivate static let userAgentString = {
        return String(format: "%@ iOS/%@ Build %@; (%@, iOS %@, Scale/%0.2f)",
                      Bundle.main.infoDictionary?[kCFBundleNameKey as String] as! String, // App name
            Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String, // App version
            Bundle.main.infoDictionary?[kCFBundleVersionKey as String] as! String, // Build version
            UIDevice.current.extendedModel(), // Device model
            UIDevice.current.systemVersion, // iOS version
            UIScreen.main.scale // Scale factor
        )
    }()
    
    fileprivate static let alamofireManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.httpAdditionalHeaders?[userAgentHeaderName] = userAgentString
        
        return Alamofire.SessionManager(configuration: configuration)
    }()

    open static func get(_ api: (url: String, mapper: (Any?) -> (Any?)),
                         parameters: [String: AnyObject]? = nil,
                         webServiceResponse: WebServiceResponseHandler) {
        
        alamofireManager.request(api.url, method: .get, parameters: parameters)
            .log(urlKey: api.url).responseJSON(completionHandler: responseHandler(forApi: api, webServiceResponse: webServiceResponse))
    }
    
    open static func post(_ api: (url: String, mapper: (Any?) -> (Any?)),
                          object: AnyObject? = nil,
                          parameters: [String: AnyObject]? = nil,
                          webServiceResponse: WebServiceResponseHandler) {
        
        alamofireManager.request(api.url, method: .post, parameters: parameters)
            .log(urlKey: api.url).responseJSON(completionHandler: responseHandler(forApi: api, webServiceResponse: webServiceResponse))
    }
    
    fileprivate static func responseHandler(forApi api: (url: String, mapper: (Any?) -> (Any?)), webServiceResponse: WebServiceResponseHandler)
        -> ((DataResponse<Any>) -> Void) {
            return {
                response in
                
                log(response, forUrlKey: api.url)
                
                switch response.result {
                case .success(let JSON):
                    let statusCode = response.response!.statusCode
                    
                    if 200 ..< 300 ~= statusCode {
                        let responseObject = api.mapper(JSON)
                        successFunction(webServiceResponse, httpStatusCode: statusCode, responseObject: responseObject)
                    }
                case .failure(let error):
                    failureFunction(webServiceResponse, httpStatusCode: 0, error: error as NSError!)
                }
            }
    }
    
    fileprivate static func successFunction(_ webServiceResponse: WebServiceResponseHandler, httpStatusCode: Int,
                                            responseObject: Any! = nil) {
        
        webServiceResponse.success(httpStatusCode, responseObject: responseObject)
        webServiceResponse.finally(httpStatusCode)
    }
    
    fileprivate static func failureFunction(_ webServiceResponse: WebServiceResponseHandler, httpStatusCode: Int,
                                            error: NSError! = nil) {
        
        defer {
            webServiceResponse.finally(httpStatusCode)
        }
        
        if error.domain == NSURLErrorDomain {
            var message = "Unknown error connecting to server"
            
            switch error.code {
                case NSURLErrorNotConnectedToInternet,
                     NSURLErrorNetworkConnectionLost: message = "Error: not connected to internet"
                case NSURLErrorCannotFindHost,
                     NSURLErrorCannotConnectToHost: message = "Error: cannot connect to host"
                default: break
            }
            
            ViewUtils.showAlert(ViewUtils.createErrorAlert(message: message))
            
            return
        }
        
        if httpStatusCode >= 500 && httpStatusCode <= 599 {
            ViewUtils.showAlert(ViewUtils.createErrorAlert(message: "Server error"))
            
            return
        }
    }
    
    fileprivate static func log(_ response: DataResponse<Any>, forUrlKey key: String) {
        let statusCode = response.response?.statusCode ?? 0
        let request = response.request!
        
        let url = request.url!.description
        
        let method = request.httpMethod!
        let requestDuration = String(format: "%.03f", response.timeline.requestDuration)
        let mappingDuration = String(format: "%.03f", response.timeline.serializationDuration)
        let totalDuration = String(format: "%.03f", response.timeline.totalDuration)
        let logLine = "\(method) \(url) (\(statusCode)) [request=\(requestDuration)s mapping=\(mappingDuration)s total=\(totalDuration)s]"
        
        DDLogInfo(logLine)
        #if DEBUG
            DDLogDebug(response.debugDescription)
        #endif
    }
    
    fileprivate static func log(_ url: String, forKey key: String, withMethod method: String) {
        DDLogInfo(method + " " + url)
    }
}


extension Request {
    
    public func log(urlKey key: String) -> Self {
        let logInfo = self.description
        
        DDLogInfo(logInfo)
        #if DEBUG
            DDLogDebug(self.debugDescription)
        #endif
        
        return self
    }
}
