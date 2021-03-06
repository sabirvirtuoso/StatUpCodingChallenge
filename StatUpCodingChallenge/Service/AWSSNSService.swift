//
//  AWSSNSService.swift
//  StatUpCodingChallenge
//
//  Created by Syed Sabir Salman on 6/7/17.
//  Copyright © 2017 Syed Sabir Salman. All rights reserved.
//

import Foundation
import AWSSNS

open class AWSSNSService {
    
    open func publish(snsMessage message: SNSMessage) {
        let sns = AWSSNS(forKey: "USWest2SNS")

        let request = AWSSNSPublishInput()
        request?.messageStructure = "json"

        let payloadDictionary = ["default": "\(message.messageToPublish())"]
        
        let jsonData = try? JSONSerialization.aws_data(withJSONObject: payloadDictionary)

        request?.message = String(data: jsonData!, encoding: String.Encoding.utf8)
        request?.targetArn = WebServiceConfigurator.awsSNSTopic

        sns.publish(request!).continueWith { (task) -> AnyObject! in
            print("error \(task.error), result:; \(task.result)")

            return nil
        }
    }
}
