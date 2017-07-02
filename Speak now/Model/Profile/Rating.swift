//
//  Rating.swift
//  Speak now
//
//  Created by GeniusDoan on 6/29/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import Foundation

class Rating: NSObject, NSCoding {
    var listening: Double!
    var pronounciation: Double!
    var fluency: Double!
    var vocabulary: Double!
    
    override init() {
        super.init()
        
        listening = 0
        pronounciation = 0
        fluency = 0
        vocabulary = 0
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(listening, forKey: "listening")
        aCoder.encode(pronounciation, forKey: "pronounciation")
        aCoder.encode(fluency, forKey: "fluency")
        aCoder.encode(vocabulary, forKey: "vocabulary")
    }
    
    required init?(coder aDecoder: NSCoder) {
        listening = aDecoder.decodeObject(forKey: "listening") as! Double
        pronounciation = aDecoder.decodeObject(forKey: "pronounciation") as! Double
        fluency = aDecoder.decodeObject(forKey: "fluency") as! Double
        vocabulary = aDecoder.decodeObject(forKey: "vocabulary") as! Double
    }
    
    init(dictionary: NSDictionary) {
        super.init()
        
        if let listening = dictionary["listening"] as? Double {
            self.listening = listening
        } else {
            listening = 0
        }
        
        if let pronounciation = dictionary["pronounciation"] as? Double {
            self.pronounciation = pronounciation
        } else {
            pronounciation = 0
        }
        
        if let fluency = dictionary["fluency"] as? Double {
            self.fluency = fluency
        } else {
            fluency = 0
        }
        
        if let vocabulary = dictionary["vocabulary"] as? Double {
            self.vocabulary = vocabulary
        } else {
            vocabulary = 0
        }
    }
    
    func dictionary() -> [String: AnyObject] {
        return ["listening": listening as AnyObject,
                "pronounciation": pronounciation as AnyObject,
                "fluency": fluency as AnyObject,
                "vocabulary": vocabulary as AnyObject]
    }
}
