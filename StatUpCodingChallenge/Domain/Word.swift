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
    var note = ""
    
    var publishDate = ""

    var definitions = [Definition]()
    
    public required init?(map: Map) {
    }
    
    override init() {
        super.init()
    }
    
    public required init(coder decoder: NSCoder) {
        word = decoder.decodeObject(forKey: "word") as! String
        note = decoder.decodeObject(forKey: "note") as! String

        publishDate = decoder.decodeObject(forKey: "publishDate") as! String
    }
    
    func encodeWithCoder(_ encoder: NSCoder) {
        encoder.encode(word, forKey: "id")
        encoder.encode(note, forKey: "note")

        encoder.encode(publishDate, forKey: "publishDate")
    }
    
    open func mapping(map: Map) {
        word            <- map["word"]
        note            <- map["note"]
        
        publishDate     <- map["publishDate"]

        definitions     <- map["definitions"]
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
        hash = hash &* 31 &+ note.hashValue
        hash = hash &* 31 &+ publishDate.hashValue
        
        return hash
    }
}

public func ==(lhs: Word, rhs: Word) -> Bool {
    
    return lhs.word == rhs.word
        && lhs.note == rhs.note
        && lhs.publishDate == rhs.publishDate
}


extension Word {
    
    public func formattedDefinitions() -> String {
        var formattedString = ""

        for definition in definitions {
            formattedString += "\(definition.formattedDefinition()) \n\n"
        }

        return formattedString
    }
}
