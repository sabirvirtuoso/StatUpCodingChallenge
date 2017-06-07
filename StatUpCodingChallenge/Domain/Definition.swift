//
//  Definition.swift
//  StatUpCodingChallenge
//
//  Created by Syed Sabir Salman on 6/7/17.
//  Copyright © 2017 Syed Sabir Salman. All rights reserved.
//

import Foundation
import ObjectMapper

open class Definition: NSObject, Mappable {
    
    var text = ""
    var source = ""
    var partOfSpeech = ""
    
    public required init?(map: Map) {
    }
    
    override init() {
        super.init()
    }
    
    public required init(coder decoder: NSCoder) {
        text = decoder.decodeObject(forKey: "text") as! String
        source = decoder.decodeObject(forKey: "source") as! String
        
        partOfSpeech = decoder.decodeObject(forKey: "partOfSpeech") as! String
    }
    
    func encodeWithCoder(_ encoder: NSCoder) {
        encoder.encode(text, forKey: "text")
        encoder.encode(source, forKey: "source")
        
        encoder.encode(partOfSpeech, forKey: "partOfSpeech")
    }
    
    open func mapping(map: Map) {
        text              <- map["text"]
        source            <- map["source"]
        
        partOfSpeech      <- map["partOfSpeech"]
    }
    
    open override func isEqual(_ object: Any!) -> Bool {
        if let obj = object as? Definition {
            return obj == self
        }
        
        return false
    }
    
    open override var hash: Int {
        return self.hashValue
    }
    
    open override var hashValue: Int {
        var hash = 17
        
        hash = hash &* 31 &+ text.hashValue
        hash = hash &* 31 &+ source.hashValue
        hash = hash &* 31 &+ partOfSpeech.hashValue
        
        return hash
    }
}

public func ==(lhs: Definition, rhs: Definition) -> Bool {
    
    return lhs.text == rhs.text
        && lhs.source == rhs.source
        && lhs.partOfSpeech == rhs.partOfSpeech
}


extension Definition {
    
    public func formattedDefinition() -> String {
        return "\(partOfSpeech) - \(text)"
    }
}
