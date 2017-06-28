//
//  User.swift
//  Speak now
//
//  Created by GeniusDoan on 6/28/17.
//  Copyright © 2017 Nha T.Tran. All rights reserved.
//

import Foundation
import UIKit

enum UserType: Int {
    case learner
    case speaker
}

class User: NSObject, NSCoding {
    static var current: User = User()
    var uid: String!
    var type: UserType!
    var name: String!
    var email: String!
    var password: String!
    //var _photoUrl: URL?
    var profilePhoto:String!
    var conversations: Int!
    var totalHours: Double!
    var rating: Double!
    var review:Review!
    var reviews: [Review]!
    
    var isSpeaker: Bool {
        get{
            return type == UserType.speaker
        }
    }
    
    override init() {
        super.init()
        
        uid = ""
        type = UserType.learner
        name = ""
        email = ""
        password = ""
        profilePhoto = ""
        conversations = 0
        totalHours = 0
        rating = 0
        review = Review()
        reviews = [Review]()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(uid, forKey: "uid")
        aCoder.encode(type?.hashValue, forKey: "type")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(password, forKey: "password")
        aCoder.encode(profilePhoto, forKey: "profilePhoto")
        aCoder.encode(conversations, forKey: "conversations")
        aCoder.encode(totalHours, forKey: "totalHours")
        aCoder.encode(rating, forKey: "rating")
        aCoder.encode(review, forKey: "review")
        aCoder.encode(reviews, forKey: "reviews")
    }
    
    required init?(coder aDecoder: NSCoder) {
        uid = aDecoder.decodeObject(forKey: "uid") as! String
        type = UserType(rawValue: aDecoder.decodeObject(forKey: "type") as! Int)
        name = aDecoder.decodeObject(forKey: "name") as! String
        email = aDecoder.decodeObject(forKey: "email") as! String
        password = aDecoder.decodeObject(forKey: "password") as! String
        profilePhoto = aDecoder.decodeObject(forKey: "profilePhoto") as! String
        conversations = aDecoder.decodeObject(forKey: "conversations") as! Int
        totalHours = aDecoder.decodeObject(forKey: "totalHours") as! Double
        rating = aDecoder.decodeObject(forKey: "rating") as! Double
        review = aDecoder.decodeObject(forKey: "review") as! Review
        reviews = aDecoder.decodeObject(forKey: "reviews") as! [Review]
    }
    
    //    func initUser(){
    //       review = Review()
    //    }
    
    func setUserPhotoView(view: UIImageView) {
        if isSpeaker {
            print(profilePhoto)
            view.setImageWith(URL(string: profilePhoto)!)
        } else {
            view.image = UIImage(named: profilePhoto)
        }
    }
    
    func speakerAverageRatings() -> Double{
        var rating:Double = 0
        if reviews.count != 0{
            for review in reviews{
                print(review.rating)
                rating += review.rating
            }
            rating /= Double(reviews.count > 0 ? reviews.count : 1)
        }
        
        return round(rating*10)/10
    }
    
    func learnerAverageRating() -> Double{
        var rating:Double = 0
        for review in reviews{
            rating += (review.stats?.listening)! + (review.stats?.pronounciation)! + (review.stats?.fluency)! + (review.stats?.vocabulary)!
        }
        rating /= Double(reviews.count > 0 ? reviews.count : 1)
        return round(rating*10)/10
    }
    
    func dictionary() -> [String: AnyObject] {
        var dict = [String: AnyObject]()
        dict["uid"] = uid as AnyObject
        dict["type"] = type as AnyObject
        dict["name"] = name as AnyObject
        dict["email"] = email as AnyObject
        dict["password"] = password as AnyObject
        dict["profilePhoto"] = profilePhoto as AnyObject
        dict["conversations"] = conversations as AnyObject
        dict["totalHours"] = totalHours as AnyObject
        dict["rating"] = rating as AnyObject
        dict["review"] = review?.dictionary() as AnyObject
        dict["reviews"] = Review.arrayDictionary(reviews: reviews) as AnyObject
        
        return dict
    }
}
