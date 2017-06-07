//
//  SNSMessage.swift
//  StatUpCodingChallenge
//
//  Created by Syed Sabir Salman on 6/7/17.
//  Copyright © 2017 Syed Sabir Salman. All rights reserved.
//

import Foundation

import Foundation
import ObjectMapper

open class SNSMessage: NSObject {
    
    var textMessage = ""

    var wordOfTheDay: Word!
    
    var userName = ""
    var sourceRepository = ""
    
    public required init?(map: Map) {
    }
    
    override init() {
        super.init()
    }

    open override func isEqual(_ object: Any!) -> Bool {
        if let obj = object as? SNSMessage {
            return obj == self
        }
        
        return false
    }
    
    open override var hash: Int {
        return self.hashValue
    }
    
    open override var hashValue: Int {
        var hash = 17
        
        hash = hash &* 31 &+ textMessage.hashValue

        hash = hash &* 31 &+ wordOfTheDay.hashValue

        hash = hash &* 31 &+ userName.hashValue
        hash = hash &* 31 &+ sourceRepository.hashValue
        
        return hash
    }
}

public func ==(lhs: SNSMessage, rhs: SNSMessage) -> Bool {
    
    return lhs.textMessage == rhs.textMessage
        && lhs.wordOfTheDay == rhs.wordOfTheDay
        && lhs.userName == rhs.userName
        && lhs.sourceRepository == rhs.sourceRepository
}


extension SNSMessage {
 
    public func messageToPublish() -> String {
        var message = textMessage

        if !userName.isEmpty {
            message += "\r\nPosted by \(userName)"
        }

        message += "Today's word of the day is \(wordOfTheDay.word) which means: \(wordOfTheDay.meaning)"
        message += "Source Repository URL: \(sourceRepository)"

        return message
    }
}
