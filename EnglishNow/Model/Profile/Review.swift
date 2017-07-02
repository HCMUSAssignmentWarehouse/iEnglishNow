//
//  Review.swift
//  EnglishNow
//
//  Created by GeniusDoan on 6/29/17.
//  Copyright © 2017 IceTeaViet. All rights reserved.
//

import Foundation

class Review: NSObject, NSCoding {
    var partner: String!
    var photoPartner: String!
    var comment: String!
    var ratings: Rating!
    var gift: Gift!
    var rating: Double!
    var recordFileName: String!
    
    override init() {
        super.init()
        
        partner = ""
        photoPartner = "man"
        comment = ""
        ratings = Rating()
        gift = Gift()
        rating = 0
        recordFileName = ""
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(partner, forKey: "partner")
        aCoder.encode(photoPartner, forKey: "photoPartner")
        aCoder.encode(comment, forKey: "comment")
        aCoder.encode(ratings, forKey: "ratings")
        aCoder.encode(gift, forKey: "gift")
        aCoder.encode(rating, forKey: "rating")
        aCoder.encode(recordFileName, forKey: "recordFileName")
    }
    
    required init?(coder aDecoder: NSCoder) {
        partner = aDecoder.decodeObject(forKey: "partner") as! String
        photoPartner = aDecoder.decodeObject(forKey: "photoPartner") as! String
        comment = aDecoder.decodeObject(forKey: "comment") as! String
        ratings = aDecoder.decodeObject(forKey: "ratings") as! Rating
        gift = aDecoder.decodeObject(forKey: "gift") as! Gift
        rating = aDecoder.decodeObject(forKey: "rating") as! Double
        recordFileName = aDecoder.decodeObject(forKey: "recordFileName") as! String
    }
    
    init(dictionary: NSDictionary) {
        super.init()
        
        if let partner = dictionary["partner"] as? String {
            self.partner = partner
        } else {
            partner = ""
        }
        
        if let photo = dictionary["photo_partner"] as? String {
            self.photoPartner = photo
        } else {
            photoPartner = ""
        }
        
        if let comment = dictionary["comment"] as? String {
            self.comment = comment
        } else {
            comment = ""
        }
        
        if let statsDictionary = dictionary["ratings"] as? NSDictionary {
            self.ratings = Rating(dictionary: statsDictionary)
        } else {
            ratings = Rating()
        }
        
        if let giftDictionary = dictionary["gift"] as? NSDictionary {
            self.gift = Gift(dictionary: giftDictionary)
        } else {
            gift = Gift()
        }
        
        if let rating = dictionary["rating"] as? Double {
            self.rating = rating
        } else {
            rating = 0
        }
        
        if let recordFileName = dictionary["recordFileName"] as? String {
            self.recordFileName = recordFileName
        } else {
            recordFileName = ""
        }
    }
    
    
    func dictionary() -> [String: AnyObject] {
        var dict = [String: AnyObject]()
        
        dict.updateValue(partner as AnyObject, forKey: "partner")
        
        dict.updateValue(photoPartner as AnyObject, forKey: "photo_partner")
        
        dict.updateValue(comment as AnyObject, forKey: "comment")
        
        if let ratings = ratings {
            dict.updateValue(ratings.dictionary() as AnyObject, forKey: "ratings")
        }
        
        if let gift = gift {
            dict.updateValue(gift.dictionary() as AnyObject, forKey: "gift")
        }
        
        dict.updateValue(rating as AnyObject, forKey: "rating")
        
        dict.updateValue(recordFileName as AnyObject, forKey: "recordFileName")
        
        return dict
    }
    
    class func arrayDictionary(reviews: [Review]) -> [[String: AnyObject]] {
        var array = [[String: AnyObject]]()
        for review in reviews {
            array.append(review.dictionary())
        }
        
        return array
    }
}
