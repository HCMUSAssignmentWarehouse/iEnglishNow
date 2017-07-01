//
//  Gift.swift
//  Speak now
//
//  Created by GeniusDoan on 6/29/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import Foundation

class Gift: NSObject, NSCoding {
    var beer:Int!
    var coke:Int!
    
    override init() {
        super.init()
        
        beer = 0
        coke = 0
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(beer, forKey: "beer")
        aCoder.encode(coke, forKey: "coke")
    }
    
    required init?(coder aDecoder: NSCoder) {
        beer = aDecoder.decodeObject(forKey: "beer") as! Int
        coke = aDecoder.decodeObject(forKey: "coke") as! Int
    }
    
    init(dictionary: NSDictionary) {
        if let beer = dictionary["beer"] as? Int {
            self.beer = beer
        } else {
            beer = 0
        }
        
        if let coke = dictionary["coke"] as? Int {
            self.coke = coke
        } else {
            coke = 0
        }
    }
    
    func dictionary() -> [String: AnyObject] {
        return ["bear": beer as AnyObject,
                "coke": coke as AnyObject]
    }
}
