//
//  Status.swift
//  EnglishNow
//
//  Created by Nha T.Tran on 6/14/17.
//  Copyright © 2017 IceTeaViet. All rights reserved.
//

import Foundation
import UIKit

class Status {
    
    var user: String?
    var content: String?
    var time: TimeInterval?
    var photo: UIImage?
    var likeNumber: Int?
    var isUserLiked: Bool?
    var username: String?
    var avatar: UIImage?
    var statusId: String?
    
    init(statusId: String , user:String, username: String, avatar: UIImage, content: String, time: TimeInterval, photo: UIImage, likeNumber: Int, isUserLiked: Bool){
        self.statusId = statusId
        self.user = user
        self.username = username
        self.avatar = avatar
        self.content = content
        self.time = time
        self.photo = photo
        self.likeNumber = likeNumber
        self.isUserLiked = isUserLiked
    }
    
    init(statusId: String , user:String, username: String, avatar: UIImage, content: String, time: TimeInterval, likeNumber: Int, isUserLiked: Bool){
        self.statusId = statusId
        self.user = user
        self.username = username
        self.avatar = avatar
        self.content = content
        self.time = time
        self.likeNumber = likeNumber
        self.isUserLiked = isUserLiked
    }
    
}
