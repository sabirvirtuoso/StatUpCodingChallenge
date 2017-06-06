//
//  Word.swift
//  StatUpCodingChallenge
//
//  Created by Syed Sabir Salman on 6/6/17.
//  Copyright © 2017 Syed Sabir Salman. All rights reserved.
//

import Foundation
import ObjectMapper

open class Word: NSObject, Mappable {
    
    var word = ""
    var meaning = ""
    
    public required init?(map: Map) {
    }
    
    override init() {
        super.init()
    }
    
    public required init(coder decoder: NSCoder) {
        word = decoder.decodeObject(forKey: "word") as! String
        meaning = decoder.decodeObject(forKey: "meaning") as! String
    }
    
    func encodeWithCoder(_ encoder: NSCoder) {
        encoder.encode(word, forKey: "id")
        encoder.encode(meaning, forKey: "meaning")
    }
    
    open func mapping(map: Map) {
        word            <- map["word"]
        meaning         <- map["meaning"]
    }

    open override func isEqual(_ object: Any!) -> Bool {
        if let obj = object as? Word {
            return obj == self
        }
        
        return false
    }
    
    open override var hash: Int {
        return self.hashValue
    }
    
    open override var hashValue: Int {
        var hash = 17
        
        hash = hash &* 31 &+ word.hashValue
        hash = hash &* 31 &+ meaning.hashValue
        
        return hash
    }
}

public func ==(lhs: Word, rhs: Word) -> Bool {
    
    return lhs.word == rhs.word
        && lhs.meaning == rhs.meaning
}
