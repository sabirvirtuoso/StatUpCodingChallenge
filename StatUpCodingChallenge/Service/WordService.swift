//
//  WordService.swift
//  StatUpCodingChallenge
//
//  Created by Syed Sabir Salman on 6/6/17.
//  Copyright © 2017 Syed Sabir Salman. All rights reserved.
//

import Foundation

open class WordService {
    
    open func retrieveWordOfTheDay(withApiKey key: String, webServiceResponse: WebServiceResponseHandler) {
        WebServiceHelper.get(WebServiceConfigurator.wordOfTheDay, parameters: ["api_key": key as AnyObject],
                             webServiceResponse: webServiceResponse)
    }
}
