//
//  AWSSNSService.swift
//  StatUpCodingChallenge
//
//  Created by Syed Sabir Salman on 6/7/17.
//  Copyright © 2017 Syed Sabir Salman. All rights reserved.
//

import Foundation
import AWSCognito
import AWSCore
import AWSSNS

open class AWSSNSSerice {
    
    open func publish(snsMessage message: SNSMessage) {
        let sns = AWSSNS(forKey: "USWest2SNS")

        let request = AWSSNSPublishInput()
        request?.messageStructure = "json"

        let dict = ["default": "The default message", "APNS_SANDBOX": "{\"aps\":{\"alert\": \"\(message.messageToPublish())\",\"sound\":\"default\", \"badge\":\"1\"} }"]
        
        let jsonData = try? JSONSerialization.aws_data(withJSONObject: dict)

        request?.message = String(data: jsonData!, encoding: String.Encoding.utf8)
        request?.targetArn = WebServiceConfigurator.awsSNSTopic

        sns.publish(request!).continueWith { (task) -> AnyObject! in
            print("error \(task.error), result:; \(task.result)")

            return nil
        }
    }
}
