//
//  WebServiceConfigurator.swift
//  StatUpCodingChallenge
//
//  Created by Syed Sabir Salman on 6/6/17.
//  Copyright © 2017 Syed Sabir Salman. All rights reserved.
//

import Foundation
import ObjectMapper

open class WebServiceConfigurator {
    
    typealias T = (url: String, mapper: (Any?) -> (Any?))
    
    static let wordOfTheDayPath = Bundle.main.infoDictionary!["wordOfTheDayApi"] as? String
    static let wordOfTheDayApiKey = Bundle.main.infoDictionary!["wordOfTheDayApiKey"] as? String
    
    static let awsIdentityPoolId = Bundle.main.infoDictionary!["AWSIdentityPoolId"] as? String
    static let awsRegion = Bundle.main.infoDictionary!["AWSRegion"] as? String
    static let awsSNSTopic = Bundle.main.infoDictionary!["AWSSNSTopic"] as? String
    
    static let wordOfTheDay: T = (wordOfTheDayPath!, { return Mapper<Word>().map(JSONObject: $0) })

}
